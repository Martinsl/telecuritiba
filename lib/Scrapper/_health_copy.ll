defmodule Telecuritiba.Scrapper.HealthCopy do
  def flag_indicators() do
    url = "https://saude.curitiba.pr.gov.br/vigilancia/epidemiologica/vigilancia-de-a-a-z/12-vigilancia/1507-monitoramento-covid-19.html"
    case HTTPotion.get(url, [timeout: 30_000]) do
      %HTTPotion.Response{ body: body, headers: _headers, status_code: 200 } ->
        # { :ok, get_all_articles(body) }
        get_all_articles(body)
      _ ->
        { :err, "not found" }
    end
  end

  defp get_all_articles(html) do
    [article_item | _t] = html#Floki.parse_document(html)
    |> Floki.find("#system article.item .content.clearfix") #  article.item
    # |> IO.inspect()

    {"div", _class, children} = article_item
    children
    |> Enum.at(0)
    |> get_after_flag()
  end

  defp get_after_flag_string(str) when is_binary(str) do
    str
    |> String.downcase
    |> String.contains?("bandeira")
  end
  defp get_after_flag_string({_type, _class, list}) do
    list
    |> Enum.map(&get_after_flag_string/1)
    |> Enum.member?(true)
  end
  defp get_after_flag_string(str), do: false

  defp get_after_flag({"ul", _class, list}) do
    IO.puts("oi")

    list
    |> Enum.map(&get_after_flag_string/1)
    |> Enum.member?(true)
  end
  defp get_after_flag({a, _class, list}) do
    IO.puts("oi2")
    case get_after_flag(list) do
      true ->
    end
    # IO.inspect(a)
  end
end
