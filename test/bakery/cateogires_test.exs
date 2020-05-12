defmodule Bakery.CateogiresTest do
  use Bakery.DataCase

  alias Bakery.Cateogires

  describe "categories" do
    alias Bakery.Cateogires.Category

    @valid_attrs %{name: "some name", slug: "some slug"}
    @update_attrs %{name: "some updated name", slug: "some updated slug"}
    @invalid_attrs %{name: nil, slug: nil}

    def category_fixture(attrs \\ %{}) do
      {:ok, category} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Cateogires.create_category()

      category
    end

    test "list_categories/0 returns all categories" do
      category = category_fixture()
      assert Cateogires.list_categories() == [category]
    end

    test "get_category!/1 returns the category with given id" do
      category = category_fixture()
      assert Cateogires.get_category!(category.id) == category
    end

    test "create_category/1 with valid data creates a category" do
      assert {:ok, %Category{} = category} = Cateogires.create_category(@valid_attrs)
      assert category.name == "some name"
      assert category.slug == "some slug"
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cateogires.create_category(@invalid_attrs)
    end

    test "update_category/2 with valid data updates the category" do
      category = category_fixture()
      assert {:ok, %Category{} = category} = Cateogires.update_category(category, @update_attrs)
      assert category.name == "some updated name"
      assert category.slug == "some updated slug"
    end

    test "update_category/2 with invalid data returns error changeset" do
      category = category_fixture()
      assert {:error, %Ecto.Changeset{}} = Cateogires.update_category(category, @invalid_attrs)
      assert category == Cateogires.get_category!(category.id)
    end

    test "delete_category/1 deletes the category" do
      category = category_fixture()
      assert {:ok, %Category{}} = Cateogires.delete_category(category)
      assert_raise Ecto.NoResultsError, fn -> Cateogires.get_category!(category.id) end
    end

    test "change_category/1 returns a category changeset" do
      category = category_fixture()
      assert %Ecto.Changeset{} = Cateogires.change_category(category)
    end
  end
end
