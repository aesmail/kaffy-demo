defmodule Bakery.Products.Product do
  use Ecto.Schema
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :price, :decimal
    field :quantity, :integer
    field :status, :string
    field :title, :string
    field :views, :integer, default: 0
    field :options, :map
    field :description, :string
    belongs_to :category, Bakery.Categories.Category

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [
      :title,
      :quantity,
      :views,
      :price,
      :status,
      :description,
      :category_id,
      :options
    ])
    |> validate_required([:title, :quantity, :price, :status, :category_id])
  end
end
