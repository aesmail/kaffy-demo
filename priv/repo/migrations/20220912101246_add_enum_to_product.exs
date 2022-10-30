defmodule Bakery.Repo.Migrations.AddEnumToProduct do
  use Ecto.Migration

  def change do
    alter table(:products) do
      add :type, :integer
    end
  end
end
