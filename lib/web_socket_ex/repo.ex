defmodule WebSocketEx.Repo do
  use Ecto.Repo,
    otp_app: :web_socket_ex,
    adapter: Ecto.Adapters.Postgres
end
