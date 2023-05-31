defmodule WebSocketEx.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :address, :string
    field :date_of_birth, :naive_datetime
    field :name, :string
    field :notifications_enabled, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :address, :date_of_birth, :notifications_enabled])
    |> validate_required([:name, :address, :date_of_birth, :notifications_enabled])
  end
end
