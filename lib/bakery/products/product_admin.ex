defmodule Bakery.Products.ProductAdmin do
  def index(_) do
    [
      title: nil,
      category_id: nil,
      price: %{value: fn p -> Decimal.to_string(p.price) end},
      quantity: nil,
      status: %{name: "Is it available?", value: fn p -> available?(p) end},
      views: nil
    ]
  end

  def form_fields(_) do
    [
      title: nil,
      status: %{choices: [{"Available", "available"}, {"Sold out", "soldout"}]},
      category_id: nil,
      description: %{type: :textarea, rows: 4},
      options: nil,
      price: nil,
      quantity: nil,
      views: %{permission: :read}
    ]
  end

  def before_save(changeset) do
    IO.inspect(changeset)
    {:ok, changeset}
  end

  def available?(product) do
    case product.status == "available" do
      true -> ~s(<span class="badge badge-success"><i class="fas fa-check"><i></span>)
      false -> ~s(<span class="badge badge-danger"><i class="fas fa-times"></i></span>)
    end
  end
end
