defmodule Bakery.Products.IngredientAdmin do
  def widgets(_, _) do
    demo_content =
      ~s(This is a demo of <a href="https://github.com/aesmail/kaffy">kaffy</a>, the elixir admin package for phoenix applications.)

    [
      %{
        type: "text",
        title: "A Demo of Kaffy v0.5.0",
        order: 5,
        width: 12,
        content: {:safe, demo_content}
      },
      %{
        type: "chart",
        title: "This week's sales",
        order: 10,
        width: 12,
        content: %{
          x: ["Mon", "Tue", "Wed", "Thu", "Today"],
          y: [150, 230, 75, 240, 290],
          y_title: "USD"
        }
      }
    ]
  end
end
