defmodule Minig.Post do
  use Ecto.Schema
  import Ecto.Changeset

  alias Minig.Customer
  @type t :: %__MODULE__{}

  schema "post" do
    field :description, :string
    field :image, :binary
    field :image_type, :string
    field :likes, :integer, default: 0
    belongs_to :customer, Customer

    timestamps()
  end

  @fields [:description, :image, :image_type, :likes, :customer_id]
  @required_fields [:description, :image, :image_type]
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @fields)
    |> validate_required(@required_fields)
  end
end
