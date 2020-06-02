defmodule Bakery.Products.Product do
  use Ecto.Schema
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :price, :decimal
    field :quantity, :integer
    field :status, :string
    field :enough, :boolean, default: true, virtual: true
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
      :enough,
      :quantity,
      :views,
      :price,
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
