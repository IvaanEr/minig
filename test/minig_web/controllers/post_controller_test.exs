defmodule MinigWeb.PostControllerTest do
  use MinigWeb.ConnCase, async: true

  alias MinigWeb.Router.Helpers
  alias Minig.Post
  alias Minig.Repo

  describe "POST create" do
    setup do
      customer = Factory.insert(:customer)
      [customer: customer]
    end

    test "creates a post with valid params", %{conn: conn, customer: customer} do
      params = %{
        customer_id: Integer.to_string(customer.id),
        description: "Nice description",
        image: %Plug.Upload{
          path: "test/support/example.png",
          content_type: "image/png",
          filename: "example.png"
        }
      }

      assert %{
               "customer_id" => customer_id,
               "description" => "Nice description",
               "image" => image,
               "image_type" => "image/png",
               "likes" => 0
             } =
               conn
               |> post(Helpers.post_path(conn, :create), params)
               |> json_response(201)

      assert customer_id == customer.id
      assert image == Base.encode64(File.read!("test/support/example.png"))
    end

    test "create a post with invalid customer_id", %{conn: conn} do
      params = %{
        customer_id: "999",
        description: "Nice description",
        image: %Plug.Upload{
          path: "test/support/example.png",
          content_type: "image/png",
          filename: "example.png"
        }
      }

      assert %{"errors" => %{"detail" => "Not Found"}} =
               conn
               |> post(Helpers.post_path(conn, :create), params)
               |> json_response(404)
    end
  end

  describe "GET index" do
    test "fetch all posts with default pagination", %{conn: conn} do
      %{id: post_id} = Factory.insert(:post)

      assert %{
               "page_number" => 1,
               "page_size" => 10,
               "total_entries" => 1,
               "total_pages" => 1,
               "entries" => entries
             } =
               conn
               |> get(Helpers.post_path(conn, :index))
               |> json_response(200)

      assert [%{"id" => ^post_id}] = entries
    end

    test "fetch more posts", %{conn: conn} do
      Factory.insert(:post)
      Factory.insert(:post)
      Factory.insert(:post)
      Factory.insert(:post)

      assert %{
               "page_number" => 1,
               "page_size" => 10,
               "total_entries" => 4,
               "total_pages" => 1,
               "entries" => entries
             } =
               conn
               |> get(Helpers.post_path(conn, :index))
               |> json_response(200)

      assert length(entries) == 4
    end

    test "fetch posts with custom pagination", %{conn: conn} do
      Factory.insert(:post)
      Factory.insert(:post)
      Factory.insert(:post)
      Factory.insert(:post)

      assert %{
               "page_number" => 1,
               "page_size" => 2,
               "total_entries" => 4,
               "total_pages" => 2,
               "entries" => entries
             } =
               conn
               |> get(Helpers.post_path(conn, :index, %{"page_number" => 1, "page_size" => 2}))
               |> json_response(200)

      assert length(entries) == 2
    end
  end

  describe "PATCH like" do
    setup do
      customer = Factory.insert(:customer)
      [customer: customer]
    end

    test "success like with valid params", %{conn: conn, customer: customer} do
      customer_id = customer.id

      assert %Post{id: post_id, likes: 0, customer_likes: []} =
               Factory.insert(:post, customer: customer)

      assert %{"id" => ^post_id, "likes" => 1} =
               conn
               |> patch(Helpers.post_post_path(conn, :like, post_id, customer_id))
               |> json_response(200)

      assert %Post{likes: 1, customer_likes: [^customer_id]} = Repo.get(Post, post_id)
    end

    test "error with invalid post_id", %{conn: conn, customer: customer} do
      customer_id = customer.id

      assert %{"errors" => %{"detail" => "Not Found"}} =
               conn
               |> patch(Helpers.post_post_path(conn, :like, 99, customer_id))
               |> json_response(404)
    end

    test "error with invalid customer_id", %{conn: conn} do
      assert %Post{id: post_id, likes: 0, customer_likes: []} = Factory.insert(:post)

      assert %{"errors" => %{"detail" => "Not Found"}} =
               conn
               |> patch(Helpers.post_post_path(conn, :like, post_id, 99))
               |> json_response(404)

      assert %Post{likes: 0, customer_likes: []} = Repo.get(Post, post_id)
    end
  end

  describe "GET customer_posts" do
    setup do
      customer = Factory.insert(:customer)
      [customer: customer]
    end

    test "get posts from an specific customer", %{conn: conn, customer: customer} do
      %Post{id: post_id} = Factory.insert(:post, customer: customer)
      %Post{} = Factory.insert(:post)

      assert %{
               "page_number" => 1,
               "page_size" => 10,
               "total_entries" => 1,
               "total_pages" => 1,
               "entries" => entries
             } =
               conn
               |> get(Helpers.post_path(conn, :customer_posts, customer.id))
               |> json_response(200)

      assert [%{"id" => ^post_id}] = entries
    end

    test "error if customer doesn't exists", %{conn: conn} do
      %Post{} = Factory.insert(:post)

      assert %{"errors" => %{"detail" => "Not Found"}} =
               conn
               |> get(Helpers.post_path(conn, :customer_posts, 999))
               |> json_response(404)
    end
  end
end
