defmodule Bakery.Tags.Tag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tags" do
    field :name, :string
    field :slug, :string
    field :status, :string
    # many_to_many :products, Bakery.Products.Product, join_through: Bakery.Products.ProductTag

    timestamps()
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:name, :slug, :status])
    |> validate_required([:name, :slug, :status])
  end
end
