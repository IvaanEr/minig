# Extend from the official Elixir image
FROM elixir:latest

# Create app directory and copy the Elixir projects into it
RUN mkdir /app
COPY . /app
WORKDIR /app

# Install hex package manager
# By using --force, we don’t need to type “Y” to confirm the installation
RUN mix local.hex --force

# Compile the project
RUN mix do compile

# Create database, run migrations, run seeds.exs and start the server
CMD mix ecto.create && mix ecto.migrate && mix run priv/repo/seeds.exs && mix phx.server