defmodule Minig.Posts do
  @moduledoc """
  Context for Posts operations
  """

  alias Minig.Repo
  alias Minig.Post

  def create(image_binary, content_type, description, customer_id) do
    params = %{
      image: image_binary,
      image_type: content_type,
      description: description,
      customer_id: customer_id
    }

    Post
    |> Post.changeset(params)
    |> Repo.insert()
  end
end
