# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Minig.Repo.insert!(%Minig.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
#
alias Minig.Customer

customers = [
  %{first_name: "Ivan", last_name: "Ernandorena"},
  %{first_name: "John", last_name: "Doe"},
  %{first_name: "Jane", last_name: "Doe"}
]

customers
|> Enum.map(fn c -> Customer.changeset(%Customer{}, c) end)
|> Enum.map(&Minig.Repo.insert!(&1))
