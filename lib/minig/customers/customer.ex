defmodule Minig.Customer do
  use Ecto.Schema
  import Ecto.Changeset

  alias Minig.Post

  @type t :: %__MODULE__{}

  schema "customer" do
    field :first_name, :string
    field :last_name, :string
    has_many :posts, Post

    timestamps()
  end

  @fields [:first_name, :last_name]
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @fields)
    |> validate_required(@fields)
  end
end
