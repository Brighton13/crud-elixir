defmodule CrudWeb.PageController do
  use CrudWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def users(conn, _params) do
users=[
  %{id: 1, name: "brighton", age: 12},
    %{id: 2, name: "bob", age: 14}
]

    json(conn, %{users: users})
  end
end
