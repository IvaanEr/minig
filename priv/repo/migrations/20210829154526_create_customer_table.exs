defmodule Minig.Repo.Migrations.CreateCustomerTable do
  use Ecto.Migration

  def change do
    create table(:customer) do
      add :first_name, :string, null: false
      add :last_name, :string, null: false
      timestamps()
    end
  end
end
