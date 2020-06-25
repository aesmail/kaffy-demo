defmodule Bakery.Kaffy.Resources do
  def build_resources(conn) do
    [
      categories: [
        name: "Asnaaf",
        tasks: [],
        widgets: [],
        pages: [],
        resources: [
          category: [schema: Bakery.Categories.Category, admin: Bakery.Categories.CategoryAdmin]
        ]
      ]
    ]
  end
end
