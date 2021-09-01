defmodule MinigWeb.CustomerView do
  use MinigWeb, :view

  def render("index.json", %{"page" => page}) do
    %{
      page_number: page.page_number,
      page_size: page.page_size,
      total_entries: page.total_entries,
      total_pages: page.total_pages,
      entries: render_many(page.entries, __MODULE__, "customer.json", as: "customer")
    }
  end

  def render("customer.json", %{"customer" => customer}) do
    %{
      id: customer.id,
      first_name: customer.first_name,
      last_name: customer.last_name,
      inserted_at: customer.inserted_at,
      updated_at: customer.updated_at
    }
  end
end
