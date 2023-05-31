defmodule WebSocketExWeb.MeliJSON do
  alias WebSocketEx.Melis.Meli

  @doc """
  Renders a list of melis.
  """
  def index(%{melis: melis}) do
    %{data: for(meli <- melis, do: data(meli))}
  end

  @doc """
  Renders a single meli.
  """
  def show(%{meli: meli}) do
    %{data: data(meli)}
  end

  defp data(%Meli{} = meli) do
    %{
      id: meli.id,
      channel: meli.channel,
      event: meli.event,
      send_message: meli.send_message
    }
  end
end
