defmodule WebSocketExWeb.MeliController do
  use WebSocketExWeb, :controller

  alias WebSocketEx.Melis
  alias WebSocketEx.Melis.Meli
  alias WebSocketEx.Repo

   import Ecto.Query, only: [limit: 2, offset: 2]

  use Filterable.Phoenix.Controller

  filterable(Melis)



  # def index(conn, _params) do
  #   page = conn.params["page"] || 1
  #   per_page = conn.params["per_page"] || 20

  #   melis = Meli
  #     |> paginate(page, per_page)
  #     |> Repo.all()

  #   render(conn, "index.html", melis: melis)
  # end

  # defp paginate(query, page, per_page) do
  #   query
  #   |> limit(^per_page)
  #   |> offset((^page - 1) * ^per_page)
  # end



   def index(conn, _params) do
  #   #melis = Melis.list_melis()
  #   #render(conn, "index.json" , melis: melis)


     with {:ok, query, filter_values} <- apply_filters(Meli, conn),
          melis                       <- Repo.all(query),
      do: render(conn, "index.json", melis: melis, meta: filter_values)


   end

  @spec new(Plug.Conn.t(), any) :: Plug.Conn.t()
  def new(conn, _params) do
    changeset = Melis.change_meli(%Meli{})
    render(conn, :new, changeset: changeset)
  end

  @spec create(Plug.Conn.t(), map) :: Plug.Conn.t()
  def create(conn, %{"meli" => meli_params}) do
    case Melis.create_meli(meli_params) do
      {:ok, meli} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", ~p"/api/melis/#{meli}")
        |> render("show.json", meli: meli)
        {:error, %Ecto.Changeset{} = changeset} ->
          conn
          |> put_status(:unprocessable_entity)
          |> render("error.json", errors: changeset.errors)
    end
  end

 # def create(conn, %{"meli" => meli_params}) do
  #  with {:ok, %Meli{} = meli} <- Melis.create_meli(meli_params) do
   #   conn
    #  |> put_status(:created)
     # |> put_resp_header("location", ~p"/api/melis/#{meli}")
      #|> render(:show, meli: meli)
   # end
  #end

  def show(conn, %{"id" => id}) do
    meli = Melis.get_meli!(id)
    render(conn, "show.json", meli: meli)
  end

  def edit(conn, %{"id" => id}) do
    meli = Melis.get_meli!(id)
    changeset = Melis.change_meli(meli)
    render(conn, :edit, meli: meli, changeset: changeset)
  end

  def update(conn, %{"id" => id, "meli" => meli_params}) do
    meli = Melis.get_meli!(id)

   with {:ok, %Meli{} = meli} <- Melis.update_meli(meli, meli_params) do
      render(conn, :show, meli: meli)
      end
  end

  def delete(conn, %{"id" => id}) do
    meli = Melis.get_meli!(id)
    {:ok, _meli} = Melis.delete_meli(meli)

    conn
    |> put_status(:no_content)
    |> render(:"no_content.json")
  end
end
