defmodule WebSocketExWeb.MeliHTML do
  use WebSocketExWeb, :html

  embed_templates "meli_html/*"

  @doc """
  Renders a meli form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def meli_form(assigns)
end
