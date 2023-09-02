defmodule Bakery.Products.IngredientAdmin do
  def widgets(_, _) do
    version_content =
      ~s(This is a demo of <a href="https://github.com/aesmail/kaffy">kaffy</a>, the elixir admin package for phoenix applications. Add a product with the word "fake" in the title and it will be deleted automatically within 60 seconds. Check the scheduled tasks feature.)

    whats_new_content =
      ~s(Fixed saving enum fields with their cast types. Check the <a href="https://github.com/aesmail/kaffy/blob/master/CHANGELOG.md">CHANGELOG</a> for more details.)

    [
      %{
        type: "text",
        title: "Kaffy #{Application.spec(:kaffy, :vsn) |> to_string()}",
        order: 5,
        width: 6,
        content: {:safe, version_content}
      },
      %{
        type: "text",
        title: "What's New",
        order: 5,
        width: 6,
        content: {:safe, whats_new_content}
      },
      %{
        type: "chart",
        title: "This week's imaginary sales",
        order: 10,
        width: 6,
        content: %{
          x: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
          y: [150, 230, 75, 240, 290, 300, 190],
          y_title: "USD"
        }
      },
      %{
        type: "chart",
        title: "Imaginary visits (last week)",
        order: 10,
        width: 6,
        content: %{
          x: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
          y: [500, 600, 480, 738, 800, 770, 920],
          y_title: "Visits"
        }
      }
    ]
  end
end
