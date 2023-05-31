defmodule WebSocketEx.Melis do
  @moduledoc """
  The Melis context.
  """

  import Ecto.Query, warn: false
  alias WebSocketEx.Repo

  alias WebSocketEx.Melis.Meli

  use Filterable.DSL
  use Filterable.Ecto.Helpers


   paginateable per_page: 20


  def get_meli!(id), do: Repo.get!(Meli, id)

  filter channel(query, value, _conn) do
      query |> where(channel: ^value)
    end


  @options param: :q
  filter email(query, value, _conn) do
    query |> where([u], ilike(u.email, ^"%#{value}%"))
  end

  @doc """
  Creates a meli.

  ## Examples

      iex> create_meli(%{field: value})
      {:ok, %Meli{}}

      iex> create_meli(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_meli(attrs \\ %{}) do
    %Meli{}
    |> Meli.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a meli.

  ## Examples

      iex> update_meli(meli, %{field: new_value})
      {:ok, %Meli{}}

      iex> update_meli(meli, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_meli(%Meli{} = meli, attrs) do
    meli
    |> Meli.changeset(attrs)
    |> Repo.update()
  end


  def get_coordinates do
    case :inet.getifaddrs() do
      {:ok, ifaddrs} ->
        coordinates = Enum.map(ifaddrs, &parse_coordinates/1)
        {:ok, coordinates}

      {:error, reason} ->
        {:error, reason}
    end
  end

defp parse_coordinates(ifaddr) do
  case ifaddr[:addr] do
    {a, b, c, d} when is_integer(a) and is_integer(b) and is_integer(c) and is_integer(d)
                  and a >= 0 and a <= 255 and b >= 0 and b <= 255
                  and c >= 0 and c <= 255 and d >= 0 and d <= 255 ->
      case :geo_postgis.point(a, b, c, d) do
        {:ok, point} -> {:ok, point}
        _ -> {:error, "Failed to create point"}
      end

    _ ->
      {:error, "Invalid IP address"}
  end
end

  defp is_ipv4({a, b, c, d}) when a in 0..255 and b in 0..255 and c in 0..255 and d in 0..255,
        do: true
  defp is_ipv4(_), do: false


















  @doc """
  Deletes a meli.

  ## Examples

      iex> delete_meli(meli)
      {:ok, %Meli{}}

      iex> delete_meli(meli)
      {:error, %Ecto.Changeset{}}

  """
  def delete_meli(%Meli{} = meli) do
    Repo.delete(meli)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking meli changes.

  ## Examples

      iex> change_meli(meli)
      %Ecto.Changeset{data: %Meli{}}

  """
  def change_meli(%Meli{} = meli, attrs \\ %{}) do
    Meli.changeset(meli, attrs)
  end
end
