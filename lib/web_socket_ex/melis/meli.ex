defmodule WebSocketEx.Melis.Meli do
  use Ecto.Schema
  import Ecto.Changeset


  schema "melis" do
    field :channel, :string
    field :event, :string
    field :send_message, :string



    timestamps()
  end

  @doc false
  def changeset(meli, attrs) do
    meli
    |> cast(attrs, [:channel, :event, :send_message])
    |> validate_required([:channel, :event, :send_message])
  end
end
