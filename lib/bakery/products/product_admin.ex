defmodule Bakery.Products.ProductAdmin do
  import Bakery.Categories, only: [get_category!: 1, list_categories: 0]

  def index(_) do
    [
      title: nil,
      category_id: %{
        value: fn p -> get_category!(p.category_id).name end,
        filters: Enum.map(list_categories(), fn c -> {c.name, c.id} end)
      },
      price: %{value: fn p -> Decimal.to_string(p.price) end},
      quantity: nil,
      status: %{
        name: "Is it available?",
        value: fn p -> available?(p) end,
        filters: [{"Available", "available"}, {"Sold out", "soldout"}]
      },
      views: nil
    ]
  end

  # def form_fields(_) do
  #   [
  #     title: nil,
  #     status: %{choices: [{"Available", "available"}, {"Sold out", "soldout"}]},
  #     category_id: nil,
  #     description: %{type: :textarea, rows: 4},
  #     options: nil,
  #     price: nil,
  #     quantity: nil,
  #     views: %{permission: :read}
  #   ]
  # end

  # def before_save(_, changeset) do
  #   IO.inspect(changeset)
  #   {:ok, changeset}
  # end

  def available?(product) do
    case product.status == "available" do
      true -> ~s(<span class="badge badge-success"><i class="fas fa-check"><i></span>)
      false -> ~s(<span class="badge badge-danger"><i class="fas fa-times"></i></span>)
    end
  end

  def resource_actions(_conn) do
    [
      publish: %{name: "Publish this product", action: fn _c, p -> restock(p) end},
      soldout: %{name: "Sold out!", action: fn _c, p -> soldout(p) end}
    ]
  end

  defp restock(product) do
    Bakery.Products.update_product(product, %{"status" => "available"})
  end

  defp soldout(product) do
    case product.id == 3 do
      true ->
        {:error, product, "This product should never be sold out!"}

      false ->
        Bakery.Products.update_product(product, %{"status" => "soldout"})
    end
  end

  def widgets(_, _) do
    product_count = Bakery.Products.count_products()

    [
      %{
        type: "tidbit",
        title: "Current Products",
        content: "#{product_count}",
        icon: "cookie-bite",
        order: 1
      },
      %{
        type: "tidbit",
        title: "Recent Visits",
        content: "1769",
        icon: "male",
        order: 2
      },
      %{
        type: "tidbit",
        title: "Average Reviews",
        content: "4.7 / 5.0",
        icon: "thumbs-up",
        order: 3
      },
      %{
        type: "progress",
        title: "Pancakes",
        content: "Customer Satisfaction",
        percentage: 79,
        order: 7
      }
    ]
  end
end
