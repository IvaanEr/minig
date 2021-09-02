defmodule MinigWeb.CustomerControllerTest do
  use MinigWeb.ConnCase, async: true

  alias MinigWeb.Router.Helpers

  describe "POST create" do
    test "creates a customer with valid params", %{conn: conn} do
      params = %{
        first_name: "John",
        last_name: "Doe"
      }

      assert %{
               "id" => id,
               "first_name" => "John",
               "last_name" => "Doe"
             } =
               conn
               |> post(Helpers.customer_path(conn, :create), params)
               |> json_response(201)
    end

    test "create a post with invalid params", %{conn: conn} do
      assert %{"errors" => _string} =
               conn
               |> post(Helpers.customer_path(conn, :create), %{"invalid" => "param"})
               |> json_response(422)
    end
  end

  describe "GET index" do
    test "fetch all customers with default pagination", %{conn: conn} do
      %{id: customer_id} = Factory.insert(:customer)

      assert %{
               "page_number" => 1,
               "page_size" => 10,
               "total_entries" => 1,
               "total_pages" => 1,
               "entries" => entries
             } =
               conn
               |> get(Helpers.customer_path(conn, :index))
               |> json_response(200)

      assert [%{"id" => ^customer_id}] = entries
    end

    test "fetch more customers", %{conn: conn} do
      Factory.insert(:customer)
      Factory.insert(:customer)
      Factory.insert(:customer)
      Factory.insert(:customer)

      assert %{
               "page_number" => 1,
               "page_size" => 10,
               "total_entries" => 4,
               "total_pages" => 1,
               "entries" => entries
             } =
               conn
               |> get(Helpers.customer_path(conn, :index))
               |> json_response(200)

      assert length(entries) == 4
    end

    test "fetch customers with custom pagination", %{conn: conn} do
      Factory.insert(:customer)
      Factory.insert(:customer)
      Factory.insert(:customer)
      Factory.insert(:customer)

      assert %{
               "page_number" => 1,
               "page_size" => 2,
               "total_entries" => 4,
               "total_pages" => 2,
               "entries" => entries
             } =
               conn
               |> get(
                 Helpers.customer_path(conn, :index, %{"page_number" => 1, "page_size" => 2})
               )
               |> json_response(200)

      assert length(entries) == 2
    end
  end

  describe "GET show" do
    test "get one customer by ID", %{conn: conn} do
      %{id: customer_id} = Factory.insert(:customer)

      assert %{"id" => ^customer_id} =
               conn
               |> get(Helpers.customer_path(conn, :show, customer_id))
               |> json_response(200)
    end

    test "get one customer with invalid ID", %{conn: conn} do
      assert %{"errors" => %{"detail" => "Not Found"}} =
               conn
               |> get(Helpers.customer_path(conn, :show, 999))
               |> json_response(404)
    end
  end
end
