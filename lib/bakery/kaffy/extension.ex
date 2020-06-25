defmodule Bakery.Kaffy.Extension do
  def stylesheets(_conn) do
    [
      {:safe, ~s(<link rel="stylesheet" href="/kaffy/somestyle.css" />)}
    ]
  end

  def javascripts(_conn) do
    [
      {:safe, ~s(<script src="https://example.com/javascript.js"></script>)}
    ]
  end
end
