defmodule Bakery.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string
      add :slug, :string
      timestamps()
    end

    create index(:categories, [:name], unique: true)
    create index(:categories, [:slug], unique: true)
  end
end
