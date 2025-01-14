defmodule Crud.ProductsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Crud.Products` context.
  """

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name",
        price: "120.5",
        stock_quantity: 42
      })
      |> Crud.Products.create_product()

    product
  end
end
