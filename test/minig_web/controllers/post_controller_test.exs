defmodule MinigWeb.PostControllerTest do
  use MinigWeb.ConnCase, async: true
  use Plug.Test

  alias MinigWeb.Router.Helpers

  describe "POST create" do
    setup do
      Application.ensure_all_started(:plug)
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
  end
end
