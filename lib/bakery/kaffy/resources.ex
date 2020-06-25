defmodule Bakery.Kaffy.Resources do
  def build_resources(_conn) do
    [
      categories: [
        name: "Categories",
        resources: [
          category: [schema: Bakery.Categories.Category, admin: Bakery.Categories.CategoryAdmin]
        ]
      ]
    ]
  end
end
