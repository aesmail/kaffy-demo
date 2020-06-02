defmodule Bakery.Products.ProductAdmin do
  import Bakery.Categories, only: [get_category!: 1, list_categories: 0]

  def index(_) do
    [
      id: nil,
      title: nil,
      category_id: %{
        value: fn p -> get_category!(p.category_id).name end,
        filters: Enum.map(list_categories(), fn c -> {c.name, c.id} end)
      },
      price: %{value: fn p -> Decimal.to_string(p.price) end},
      quantity: nil,
      status: %{
        name: "Is it available?",
        value: fn p -> {:safe, available?(p)} end,
        filters: [{"Available", "available"}, {"Sold out", "soldout"}]
      },
      views: nil
    ]
  end

  def search_fields(_) do
    [
      :description,
      category: [:name]
    ]
  end

  def custom_pages(_schema, _conn) do
    [
      %{
        slug: "my-own-thing",
        name: "Secret Place",
        view: BakeryWeb.ProductView,
        template: "custom_product.html",
        assigns: [custom_message: "one two three"],
        order: 2
      }
    ]
  end

  def ordering(_) do
    [asc: :title]
  end

  def form_fields(_) do
    [
      title: %{update: :readonly},
      status: %{choices: [{"Available", "available"}, {"Sold out", "soldout"}]},
      enough: %{type: :boolean_switch},
      category_id: %{update: :readonly},
      description: %{type: :richtext},
      options: %{create: :hidden},
      price: nil,
      quantity: nil,
      views: %{update: :readonly, create: :readonly},
      inserted_at: nil
    ]
  end

  # def before_save(_, changeset) do
  #   IO.inspect(changeset)
  #   {:ok, changeset}
  # end

  def available?(product) do
    case product.status == "available" do
      true -> ~s(<span class="badge badge-success"><i class="mdi mdi-check"><i></span>)
      false -> ~s(<span class="badge badge-danger"><i class="mdi mdi-close"></i></span>)
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

  def list_actions(_) do
    [
      soldout: %{name: "Mark as soldout", action: fn _, products -> list_soldout(products) end},
      restock: %{name: "Bring back", action: fn _, products -> bring_back(products) end},
      not_good: %{name: "Error me out", action: fn _, _ -> {:error, "Expected error"} end}
    ]
  end

  defp list_soldout(products) do
    for p <- products do
      Bakery.Products.update_product(p, %{"status" => "soldout"})
    end

    :ok
  end

  defp bring_back(products) do
    for p <- products do
      Bakery.Products.update_product(p, %{"status" => "available"})
    end

    :ok
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

  def scheduled_tasks(_) do
    [
      %{
        name: "Cache Product Count",
        initial_value: 0,
        every: 300,
        action: fn _v ->
          count = Bakery.Products.count_products()
          {:ok, count}
        end
      },
      %{
        name: "Delete Fake Products",
        every: 60,
        initial_value: nil,
        action: fn _ ->
          Bakery.Products.delete_fake_products()
          {:ok, nil}
        end
      }
    ]
  end

  def custom_links(_) do
    [
      %{location: :top, order: 3, name: "Phoenix Home", url: "https://phoenixframework.org"},
      %{location: :top, order: 2, name: "Elixir Home", url: "https://elixir-lang.org"}
    ]
  end
end
