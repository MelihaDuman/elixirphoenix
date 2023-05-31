defmodule WebSocketEx.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :address, :string
      add :date_of_birth, :naive_datetime
      add :notifications_enabled, :boolean, default: false, null: false

      timestamps()
    end
  end
end
