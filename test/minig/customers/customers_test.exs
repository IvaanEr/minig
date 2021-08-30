defmodule Minig.CustomersTest do
  use Minig.DataCase

  alias Minig.Customers

  describe "exists?/1" do
    test "returns true when customer exists" do
      %{id: id} = Factory.insert(:customer)

      assert Customers.exists?(id)
    end

    test "returns false when customer doesn't exists" do
      refute Customers.exists?(900)
    end
  end
end
