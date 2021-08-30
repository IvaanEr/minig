defmodule MinigWeb.Router do
  use MinigWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/minig/v1", MinigWeb do
    pipe_through :api

    resources "/post", PostController, only: [:create, :index] do
      patch "/post/:post_id/like", PostController, :like
      get "/post/:customer_id", PostController, :customer_posts
    end
  end
end
