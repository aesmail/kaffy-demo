defmodule Bakery.Repo.Migrations.CreateIngredients do
  use Ecto.Migration

  def change do
    create table(:ingredients) do
      add :name, :string
      add :organic, :boolean, default: false, null: false
      add :product_id, references(:products, on_delete: :nothing)

      timestamps()
    end

    create index(:ingredients, [:product_id])
  end
end
