defmodule CrudWeb.ProductJSON do
  alias Crud.Products.Product

  @doc """
  Renders a list of products.
  """
  def index(%{products: products}) do
    %{data: for(product <- products, do: data(product))}
  end

  @doc """
  Renders a single product.
  """
  def show(%{product: product}) do
    %{product: data(product)}
  end


  defp data(%Product{} = product) do
    %{
      id: product.id,
      name: product.name,
      description: product.description,
      price: Decimal.new(product.price),
      stock_quantity: product.stock_quantity
    }
  end


  defimpl Jason.Encoder, for: Decimal do
    def encode(value, opts) do
      value
      |> Decimal.to_string() # Convert the Decimal to a float
      |> Jason.Encode.string(opts) # Use Jason's float encoder
    end
  end


end
