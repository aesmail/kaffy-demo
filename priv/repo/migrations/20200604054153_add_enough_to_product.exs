defmodule Bakery.Repo.Migrations.AddEnoughToProduct do
  use Ecto.Migration

  def change do
    alter table(:products) do
      add :enough, :boolean, default: true, null: false
    end
  end
end
