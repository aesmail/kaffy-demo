defmodule Bakery.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :price, :decimal
    field :quantity, :integer
    field :status, :string
    field :enough, :boolean, default: true
    # Bakery.URLField
    field :retail, :string
    field :title, :string
    field :views, :integer, default: 0
    field :options, :map
    field :description, :string
    belongs_to :category, Bakery.Categories.Category
    # many_to_many :tags, Bakery.Tags.Tag, join_through: Bakery.Products.ProductTag

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [
      :title,
      :enough,
      :quantity,
      :views,
      :price,
      :retail,
      :status,
      :description,
      :category_id,
      :options,
      :inserted_at
    ])
    |> validate_required([:title, :quantity, :price, :status, :category_id])
    |> default_title()
  end

  defp default_title(changeset) do
    cs =
      case get_field(changeset, :title) do
        nil ->
          put_change(changeset, :title, "Your Title Goes Here")

        _ ->
          changeset
      end

    IO.inspect(cs.data)
    cs
  end
end
