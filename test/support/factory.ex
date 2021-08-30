defmodule Minig.Support.Factory do
  use ExMachina.Ecto, repo: Minig.Repo

  alias Minig.Customer
  alias Minig.Post

  def customer_factory do
    %Customer{
      first_name: "John",
      last_name: "Doe"
    }
  end

  def post_factory(attrs) do
    %Post{
      description: "Nice description",
      image: "Aaaa==?sd",
      image_type: "image/jpeg",
      customer: build(:customer)
    }
    |> merge_attributes(attrs)
  end
end
