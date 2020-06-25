defmodule Bakery.Repo.Migrations.CreateProductsTags do
  use Ecto.Migration

  def change do
    create table(:products_tags, primary_key: false) do
      add :product_id, references(:products, on_delete: :nothing), null: false, primary_key: true
      add :tag_id, references(:tags, on_delete: :nothing), null: false, primary_key: true
      timestamps()
    end

    create index(:products_tags, [:product_id])
    create index(:products_tags, [:tag_id])
    create index(:products_tags, [:product_id, :tag_id], unique: true)
  end
end
