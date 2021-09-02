defmodule MinigWeb.FallbackController do
  use MinigWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(MinigWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(MinigWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, :bad_request}) do
    conn
    |> put_status(:bad_request)
    |> put_view(MinigWeb.ErrorView)
    |> render(:"400")
  end

  def call(conn, {:error, :internal_server_error}) do
    conn
    |> put_status(:internal_server_error)
    |> put_view(MinigWeb.ErrorView)
    |> render(:"500")
  end
end
