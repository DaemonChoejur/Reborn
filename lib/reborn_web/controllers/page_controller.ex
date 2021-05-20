defmodule RebornWeb.PageController do
  use RebornWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
