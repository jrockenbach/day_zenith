defmodule DayZenithWeb.PageController do
  use DayZenithWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
