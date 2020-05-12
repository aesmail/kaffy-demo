defmodule Bakery.Repo.Migrations.AddViewsToProduct do
  use Ecto.Migration

  def change do
    alter table(:products) do
      add :views, :integer, default: 0, null: false
    end
  end
end
