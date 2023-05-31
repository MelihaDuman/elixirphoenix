defmodule WebSocketEx.Web do
  @moduledoc """
  The Web context.
  """

  import Ecto.Query, warn: false
  alias WebSocketEx.Repo

  alias WebSocketEx.Web.Meli

  @doc """
  Returns the list of melis.

  ## Examples

      iex> list_melis()
      [%Meli{}, ...]

  """
  def list_melis do
    Repo.all(Meli)
  end

  @doc """
  Gets a single meli.

  Raises `Ecto.NoResultsError` if the Meli does not exist.

  ## Examples

      iex> get_meli!(123)
      %Meli{}

      iex> get_meli!(456)
      ** (Ecto.NoResultsError)

  """
  def get_meli!(id), do: Repo.get!(Meli, id)

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
