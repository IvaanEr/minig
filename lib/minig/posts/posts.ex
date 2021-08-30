defmodule Minig.Posts do
  @moduledoc """
  Context for Posts operations
  """

  alias Minig.Repo
  alias Minig.Post
  import Ecto.Query

  @doc """
  Determines if a Post exists in the database.
  """
  @spec exists?(binary()) :: boolean()
  def exists?(post_id) do
    case Repo.get(Post, post_id) do
      nil -> false
      %Post{} -> true
    end
  end

  @doc """
  Creates a new Post
  The image will be saved in the database encoded in base64
  """
  @spec create(binary(), binary(), binary(), binary()) ::
          {:ok, Post.t()} | {:error, Ecto.Changeset.t()}
  def create(image_binary, content_type, description, customer_id) do
    params = %{
      image: image_binary,
      image_type: content_type,
      description: description,
      customer_id: customer_id
    }

    %Post{}
    |> Post.changeset(params)
    |> Repo.insert()
  end

  @doc """
  Get a list of Posts, from newest to oldest.
  """
  @spec get() :: list(Post.t())
  def get() do
    Post
    |> order_by(desc: :inserted_at)
    |> Repo.all()
  end

  @doc """
  Get a list of Posts from one Customer, from newest to oldest
  """
  @spec by_customer(binary()) :: list(Post.t())
  def by_customer(customer_id) do
    Post
    |> where([p], p.customer_id == ^customer_id)
    |> Repo.all()
  end

  @doc """
  Update a Post with a new like if and only if the customer didn't like
  this Post yet.
  """
  @spec like(binary(), binary()) :: {:ok, Post.t()} | {:error, Ecto.Changeset.t()}
  def like(post_id, customer_id) do
    %Post{customer_likes: customer_likes} = post = Repo.get(Post, post_id)

    if Enum.member?(customer_likes, customer_id) do
      {:ok, post}
    else
      post
      |> Ecto.Changeset.change(
        likes: post.likes + 1,
        customer_likes: [customer_id | post.customer_likes]
      )
      |> Repo.update(returning: true)
    end
  end
end
