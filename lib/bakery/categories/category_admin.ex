defmodule Bakery.Categories.CategoryAdmin do
  import Bakery.Categories, only: [list_categories: 0]

  def plural_name(_) do
    "Categories"
  end

  def widgets(_, _) do
    categories_count = list_categories() |> length()
    latest_product = Bakery.Products.latest_product()

    [
      %{
        type: "tidbit",
        title: "Total Sales",
        content: "#{categories_count * 864}",
        order: 4,
        icon: "credit-card"
      },
      %{
        type: "text",
        title: "Latest Product",
        order: 5,
        content: "The latest product is #{latest_product.title}"
      }
    ]
  end
end
