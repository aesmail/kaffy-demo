defmodule Bakery.Repo.Migrations.AddOptionsToProduct do
  use Ecto.Migration

  def change do
    alter table(:products) do
      add :options, :map
    end
  end
end
