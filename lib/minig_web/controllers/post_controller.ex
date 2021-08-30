defmodule MinigWeb.PostController do
  use MinigWeb, :controller

  alias Minig.Customers
  alias Minig.Posts

  action_fallback MinigWeb.FallbackController

  def create(conn, %{
        "image" => %Plug.Upload{} = image,
        "customer_id" => customer_id,
        "description" => description
      }) do
    with customer_id <- String.to_integer(customer_id),
         true <- Customers.exists?(customer_id),
         {:ok, image_binary} <- File.read(image.path),
         {:ok, post} <- Posts.create(image_binary, image.content_type, description, customer_id) do
      conn
      |> put_status(201)
      |> render("post.json", %{"post" => post})
    else
      false ->
        {:error, :not_found}

      _ ->
        {:error, :internal}
    end
  end

  def index(conn, _params) do
    conn = fetch_query_params(conn)
    pagination = build_pagination(conn)

    page =
      Posts.get(limit: pagination.page_size)
      |> Scrivener.paginate(pagination)

    render(conn, "index.json", %{"page" => page})
  end

  def like(conn, %{"post_id" => post_id, "customer_id" => customer_id}) do
    with customer_id <- String.to_integer(customer_id),
         true <- Posts.exists?(post_id),
         true <- Customers.exists?(customer_id),
         {:ok, post} <- Posts.like(post_id, customer_id) do
      render(conn, "post.json", %{"post" => post})
    else
      false ->
        {:error, :not_found}

      _ ->
        {:error, :internal}
    end
  end

  def customer_posts(conn, %{"customer_id" => customer_id}) do
    conn = fetch_query_params(conn)
    pagination = build_pagination(conn)

    with customer_id <- String.to_integer(customer_id),
         true <- Customers.exists?(customer_id),
         posts <- Posts.by_customer(customer_id, limit: pagination.page_size),
         page <- Scrivener.paginate(posts, pagination) do
      render(conn, "index.json", %{"page" => page})
    else
      false ->
        {:error, :not_found}

      _ ->
        {:error, :internal}
    end
  end

  defp build_pagination(%{"page_number" => page_number, "page_size" => page_size}),
    do: %Scrivener.Config{
      page_number: String.to_integer(page_number),
      page_size: String.to_integer(page_size)
    }

  defp build_pagination(%{"page_number" => page_number}),
    do: %Scrivener.Config{page_number: String.to_integer(page_number), page_size: 10}

  defp build_pagination(_conn), do: %Scrivener.Config{page_number: 1, page_size: 10}
end
