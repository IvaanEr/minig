defmodule Minig.Customers do
  @moduledoc """
  Context for Customers operations
  """
  alias Minig.Repo
  alias Minig.Customer

  def exists?(customer_id) do
    case Repo.get(Customer, customer_id) do
      nil -> false
      %Customer{} -> true
    end
  end
end
