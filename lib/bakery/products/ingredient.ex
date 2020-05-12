defmodule Bakery.Products.Ingredient do
  use Ecto.Schema
  import Ecto.Changeset

  schema "ingredients" do
    field :name, :string
    field :organic, :boolean, default: false
    belongs_to :product, Bakery.Products.Product

    timestamps()
  end

  @doc false
  def changeset(ingredient, attrs) do
    ingredient
    |> cast(attrs, [:name, :organic, :product_id])
    |> validate_required([:name, :organic])
  end
end
