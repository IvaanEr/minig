defmodule Minig.Post do
  use Ecto.Schema
  import Ecto.Changeset

  alias Minig.Customer
  @type t :: %__MODULE__{}

  @derive {Jason.Encoder,
           only: [
             :description,
             :image,
             :image_type,
             :likes,
             :customer_id,
             :inserted_at,
             :updated_at
           ]}
  schema "post" do
    field :description, :string
    field :image, :binary
    field :image_type, :string
    field :likes, :integer, default: 0
    field :customer_likes, {:array, :integer}, default: []
    belongs_to :customer, Customer

    timestamps()
  end

  @fields [:description, :image, :image_type, :likes, :customer_likes, :customer_id]
  @required_fields [:description, :image, :image_type]
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @fields)
    |> validate_required(@required_fields)
    |> encode_image()
  end

  def encode_image(%Ecto.Changeset{valid?: true} = changeset) do
    encoded_image =
      changeset
      |> fetch_change!(:image)
      |> Base.encode64()

    put_change(changeset, :image, encoded_image)
  end

  def encoded_image(%Ecto.Changeset{valid?: false} = changeset), do: changeset
end
