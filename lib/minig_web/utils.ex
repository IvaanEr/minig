defmodule MinigWeb.Utils do
  @moduledoc """
  Utility functions for Controllers and Views
  """

  @doc """
  Build the Scrivener Config for pagination from %Plug.Conn{}
  Default pagination:
    - page_number: 1
    - page_size: 10
  """
  @spec build_pagination(Plug.Conn.t()) :: Scrivener.Config.t()
  def build_pagination(%{query_params: %{"page_number" => page_number, "page_size" => page_size}}),
    do: %Scrivener.Config{
      page_number: String.to_integer(page_number),
      page_size: String.to_integer(page_size)
    }

  def build_pagination(%{query_params: %{"page_number" => page_number}}),
    do: %Scrivener.Config{page_number: String.to_integer(page_number), page_size: 10}

  def build_pagination(_conn), do: %Scrivener.Config{page_number: 1, page_size: 10}
end
