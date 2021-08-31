defmodule MinigWeb.PostView do
  use MinigWeb, :view

  def render("index.json", %{"page" => page}) do
    %{
      page_number: page.page_number,
      page_size: page.page_size,
      total_entries: page.total_entries,
      total_pages: page.total_pages,
      entries: render_many(page.entries, __MODULE__, "post.json", as: "post")
    }
  end

  def render("post.json", %{"post" => post}) do
    %{
      id: post.id,
      image: post.image,
      description: post.description,
      image_type: post.image_type,
      likes: post.likes,
      customer_id: post.customer_id,
      inserted_at: post.inserted_at,
      updated_at: post.updated_at
    }
  end
end
