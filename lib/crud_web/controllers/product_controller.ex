defmodule CrudWeb.ProductController do
  use CrudWeb, :controller

  alias Crud.Products
  alias Crud.Products.Product

  action_fallback CrudWeb.FallbackController

  def index(conn, _params) do
    products = Products.list_products()
    render(conn, :index, products: products)
  end



  #create the product(POST-REQ)
  def create(conn, %{"product" => product_params}) do
    with {:ok, %Product{} = product} <- Products.create_product(product_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/v1/products/#{product}")
      |> render(:show, product: product)
    end
  end

  #read a single product(GET-REQ)
  def show(conn, %{"id" => id}) do
    product = Products.get_product!(id)
    render(conn, :show, product: product)
  end

  #update a single product(PUT-REQ)
  def update(conn, %{"id" => id, "product" => product_params}) do
    product = Products.get_product!(id)

    with {:ok, %Product{} = product} <- Products.update_product(product, product_params) do
      render(conn, :show, product: product)
    end
  end

  #delete a single product(DELETE-REQ)
  def delete(conn, %{"id" => id}) do
    product = Products.get_product!(id)

    with {:ok, %Product{}} <- Products.delete_product(product) do
      send_resp(conn, :no_content, "")
    end
  end
end
