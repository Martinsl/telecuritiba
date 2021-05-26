defmodule Telecuritiba do
  @moduledoc """
  Documentation for `Telecuritiba`.
  """

  @doc """
  My index.

  ## Examples

      iex> Telecuritiba.index()
      :index

  """
  def index do
    :index
  end

  def retrieve_all() do
    Telecuritiba.Scrapper.Health.flag_indicators()
  end

  # def index(:info) do
  # end

  # def index(:latest) do
  # end

  # defp index(:register) do
  # end
end
