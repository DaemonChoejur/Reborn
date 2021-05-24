defmodule RebornWeb.PageController do
  use RebornWeb, :controller

  def index(conn, _params) do
    :telemetry.execute([:rebornweb, :index], %{})

    render(conn, "index.html")
  end
end
