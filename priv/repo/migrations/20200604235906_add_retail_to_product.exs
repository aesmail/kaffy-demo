defmodule Bakery.Repo.Migrations.AddRetailToProduct do
  use Ecto.Migration

  def change do
    alter table(:products) do
      add :retail, :string
    end
  end
end
