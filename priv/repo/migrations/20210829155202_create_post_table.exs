defmodule Minig.Repo.Migrations.CreatePostTable do
  use Ecto.Migration

  def change do
    create table(:post) do
      add :description, :string, null: false
      add :image, :binary, null: false
      add :image_type, :string, null: false
      add :likes, :integer, default: 0
      add :customer_id, references(:customer), null: false
      timestamps()
    end
  end
end
