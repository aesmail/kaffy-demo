defmodule Bakery.Kaffy.Tasks do
  def title(), do: "Repeated Chores"

  def task_cache_product_count() do
    %{
      name: "Cache Product Count",
      initial_value: 0,
      every: 300,
      action: fn _v ->
        count = Bakery.Products.count_products()
        {:ok, count}
      end
    }
  end

  def task_delete_fake_products() do
    %{
      name: "Delete Fake Products",
      every: 60,
      initial_value: nil,
      action: fn _ ->
        Bakery.Products.delete_fake_products()
        {:ok, nil}
      end
    }
  end

  def normal_function() do
    IO.puts("This should not count as a task")
  end
end
