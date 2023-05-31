defmodule WebSocketEx.Repo.Migrations.CreateMelis do
  use Ecto.Migration

  def change do
    create table(:melis) do
      add :channel, :string
      add :event, :string
      add :send_message, :string

      timestamps()
    end
  end
end
