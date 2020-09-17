defmodule ObanExampleWeb.PageController do
  use ObanExampleWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
