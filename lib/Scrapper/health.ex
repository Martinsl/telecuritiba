defmodule Telecuritiba.Scrapper.Health do
  import Meeseeks.XPath
  @xpath_expr "//a[text()[contains(.,'Bandeira')]]"
  @root_url "https://saude.curitiba.pr.gov.br"

  def flag_indicators() do
    url = @root_url <> "/vigilancia/epidemiologica/vigilancia-de-a-a-z/12-vigilancia/1507-monitoramento-covid-19.html"
    case HTTPotion.get(url, [timeout: 30_000]) do
      %HTTPotion.Response{ body: body, headers: _headers, status_code: 200 } ->
        { :ok, get_all_links(body) }
      _ ->
        { :err, "not found" }
    end
  end

  @doc """
  get_all_links is responsible for getting all the information currently available in the website
  and returning it in a list of %Telecuritiba.Scrapper.Link{}

  ## Examples

      iex> Telecuritiba.Scrapper.Health.get_all_links(document)
      [
        %Telecuritiba.Scrapper.Link{
          href: "https://saude.curitiba.pr.gov.br/images/Painel_de_bandeiras_Curitiba_10-05-2021.pdf",
          text: "49. Bandeira semana 04.05 a 10.05.2021"
        },
        %Telecuritiba.Scrapper.Link{
          href: "https://saude.curitiba.pr.gov.br/images/Painel_de_bandeiras_Curitiba_05_05_2021.pdf",
          text: "48. Bandeira semana 29.04 a 05.05.2021"
        }
      ]
  """
  defp get_all_links(document) do
    document
    |> Meeseeks.all(xpath(@xpath_expr))
    |> Enum.map(fn a_tag ->
        %Telecuritiba.Scrapper.Link{
          href: @root_url <> Meeseeks.attr(a_tag, "href"),
          text: Meeseeks.text(a_tag)
        } end )
  end
end
