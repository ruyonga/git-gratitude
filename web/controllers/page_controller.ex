defmodule GitGratitude.PageController do
  use GitGratitude.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
