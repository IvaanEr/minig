defmodule MinigWeb.FallbackController do
  use MinigWeb, :controller

  def call(conn, {:error, :not_found}) do
    conn
    |> send_resp(404, "not found")
  end

  def call(conn, {:error, _}) do
    conn
    |> send_resp(500, "internal server error")
  end
end
