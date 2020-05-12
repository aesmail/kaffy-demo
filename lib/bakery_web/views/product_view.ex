defmodule BakeryWeb.ProductView do
  use BakeryWeb, :view
  alias BakeryWeb.ProductView

  def render("index.json", %{products: products}) do
    %{data: render_many(products, ProductView, "product.json")}
  end

  def render("show.json", %{product: product}) do
    %{data: render_one(product, ProductView, "product.json")}
  end

  def render("product.json", %{product: product}) do
    %{id: product.id,
      title: product.title,
      quantity: product.quantity,
      price: product.price,
      status: product.status}
  end
end
