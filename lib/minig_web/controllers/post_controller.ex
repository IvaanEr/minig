defmodule MinigWeb.PostController do
  use MinigWeb, :controller

  alias Minig.Customers
  alias Minig.Posts

  def create(conn, %{
        "image" => %Plug.Upload{} = image,
        "customer_id" => customer_id,
        "description" => description
      }) do
    with true <- Customers.exists?(customer_id),
         {:ok, image_binary} <- File.read(image.path),
         {:ok, _post} <- Posts.create(image_binary, image.content_type, description, customer_id) do
      conn
      |> send_resp(201, "Created")
    end
  end

  def index(conn, params) do
    IO.inspect(params)

    conn
    |> send_resp(201, nil)
  end

  def like(conn, params) do
    IO.inspect(params)

    conn
    |> send_resp(201, nil)
  end

  def customer_posts(conn, params) do
    IO.inspect(params)

    conn
    |> send_resp(201, nil)
  end
end
