defmodule Bakery.Products.ProductTag do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false

  schema "products_tags" do
    belongs_to :product, Bakery.Products.Product, primary_key: true
    belongs_to :tag, Bakery.Tags.Tag, primary_key: true

    timestamps()
  end

  @doc false
  def changeset(product_tag, attrs) do
    product_tag
    |> cast(attrs, [:product_id, :tag_id])
    |> validate_required([:product_id, :tag_id])
  end
end
