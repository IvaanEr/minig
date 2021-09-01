defmodule MinigWeb.CustomerController do
  use MinigWeb, :controller

  action_fallback MinigWeb.FallbackController

  alias Minig.Customer
  alias Minig.Customers
  alias MinigWeb.Utils

  def create(conn, params) do
    IO.inspect(params)

    with {:ok, %Customer{} = c} <- Customers.create(params) do
      conn
      |> put_status(201)
      |> render("customer.json", %{"customer" => c})
    end
  end

  def index(conn, _params) do
    conn = fetch_query_params(conn)
    pagination = Utils.build_pagination(conn)

    page =
      Customers.get()
      |> Scrivener.paginate(pagination)

    render(conn, "index.json", %{"page" => page})
  end

  def show(conn, %{"id" => customer_id}) do
    with customer_id <- String.to_integer(customer_id),
         %Customer{} = c <- Customers.by_id(customer_id) do
      render(conn, "customer.json", %{"customer" => c})
    else
      nil -> {:error, :not_found}
      _ -> {:error, :internal_server_error}
    end
  end
end
