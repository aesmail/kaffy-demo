defmodule BakeryWeb.IngredientView do
  use BakeryWeb, :view
  alias BakeryWeb.IngredientView

  def render("index.json", %{ingredients: ingredients}) do
    %{data: render_many(ingredients, IngredientView, "ingredient.json")}
  end

  def render("show.json", %{ingredient: ingredient}) do
    %{data: render_one(ingredient, IngredientView, "ingredient.json")}
  end

  def render("ingredient.json", %{ingredient: ingredient}) do
    %{id: ingredient.id,
      name: ingredient.name,
      organic: ingredient.organic}
  end
end
