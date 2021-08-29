defmodule Minig.Repo.Migrations.CreateCustomerTable do
  use Ecto.Migration

  def change do
    create table(:customer) do
      add :first_name, :string
      add :last_name, :string
      timestamps()
    end
  end
end
