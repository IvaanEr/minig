defmodule MinigWeb.Router do
  use MinigWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MinigWeb do
    pipe_through :api
  end
end
