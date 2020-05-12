defmodule BakeryWeb.PageController do
  use BakeryWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
