defmodule Telecuritiba.Scrapper.Link do
  @type t :: %__MODULE__{
    text:    String.t,
    href: String.t
  }
  @enforce_keys [:text, :href]

  defstruct [:text, :href]
end
