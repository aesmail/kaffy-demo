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
      # retail: nil,
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

  # def custom_pages(_schema, _conn, location \\ :sub) do
  #   [
  #     %{
  #       slug: "my-own-thing",
  #       name: "Secret Place",
  #       location: :sub,
  #       authorized?: fn conn, params -> am_i_authorized?(conn, params) end,
  #       get: fn conn, params -> secret_get(conn, params) end,
  #       post: fn conn, params -> secret_post(conn, params) end,
  #       order: 2
  #     }
  #   ]
  #   |> Enum.map(fn page -> Map.merge(%{location: :sub, order: 999}, page) end)
  #   |> Enum.filter(fn page -> page.location == location end)
  # end

  # defp am_i_authorized?(_conn, _params) do
  #   true
  # end

  # defp secret_get(_conn, _params) do
  #   {BakeryWeb.ProductView, "custom_product.html", [custom_message: "Hello World"]}
  # end

  # defp secret_post(_conn, _params) do
  #   {BakeryWeb.ProductView, "custom_product.html", [custom_message: "Goodbye World"]}
  # end

  def ordering(_) do
    [asc: :title]
  end

  def form_fields(_conn) do
    [
      title: %{update: :readonly},
      status: %{choices: [{"Available", "available"}, {"Sold out", "soldout"}]},
      enough: %{type: :boolean_switch},
      # retail: nil,
      type: nil,
      category_id: %{update: :readonly},
      description: %{type: :richtext},
      options: %{create: :hidden},
      price: nil,
      quantity: nil,
      views: %{update: :readonly, create: :readonly},
      # tags: nil,
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
    products =
      Bakery.Categories.list_categories()
      |> Enum.map(fn %{id: id, name: name} -> [name, id] end)

    [
      change_price: %{
        name: "Change the price",
        inputs: [
          %{name: "new_price", title: "New Price", default: "3"}
        ],
        action: fn _conn, products, params -> change_price(products, params) end
      },
      soldout: %{name: "Mark as soldout", action: fn _, products -> list_soldout(products) end},
      restock: %{name: "Bring back", action: fn _, products -> bring_back(products) end},
      not_good: %{name: "Error me out", action: fn _, _ -> {:error, "Expected error"} end},
      copy_products: %{
        name: "Change Category",
        inputs: [
          %{name: "new_category", title: "Select Category", use_select: true, options: products}
        ],
        action: fn _conn, products, params ->
          category_id = Map.get(params, "new_category") |> String.to_integer()

          Enum.map(products, fn p ->
            Ecto.Changeset.change(p, %{category_id: category_id})
            |> Bakery.Repo.update()
          end)

          :ok
        end
      }
    ]
  end

  defp change_price(products, params) do
    new_price = Map.get(params, "new_price") |> Decimal.new()

    Enum.map(products, fn p ->
      Ecto.Changeset.change(p, %{price: new_price})
      |> Bakery.Repo.update()
    end)

    :ok
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
      %{
        location: :bottom,
        method: :get,
        order: 3,
        name: "Phoenix Home",
        url: "https://phoenixframework.org",
        data: [confirm: "You can configure this message."]
      },
      %{
        location: :bottom,
        order: 2,
        name: "Elixir Home",
        url: "https://elixir-lang.org",
        data: [confirm: "This alert message is customizable."]
      }
    ]
  end
end
