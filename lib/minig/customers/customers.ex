defmodule Minig.Customers do
  @moduledoc """
  Context for Customers operations
  """
  alias Minig.Repo
  alias Minig.Customer

  import Ecto.Query

  @doc """
  Determines if a Customer exists in the database.
  """
  @spec exists?(binary()) :: boolean()
  def exists?(customer_id) do
    case Repo.get(Customer, customer_id) do
      nil -> false
      %Customer{} -> true
    end
  end

  @doc """
  Create a new Customer
  Params
    - first_name :: string
    - last_name :: string
  """
  @spec create(map()) :: {:ok, Customer.t()} | {:error, Ecto.Changeset.t()}
  def create(params) do
    %Customer{}
    |> Customer.changeset(params)
    |> Repo.insert()
  end

  @doc """
  Get a list of Customers, from newest to oldest
  """
  @spec get() :: [Customer.t()]
  def get do
    Customer
    |> order_by(desc: :inserted_at)
    |> Repo.all()
  end

  def by_id(customer_id), do: Repo.get(Customer, customer_id)
end
