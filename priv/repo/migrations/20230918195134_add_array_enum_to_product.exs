defmodule Bakery.Repo.Migrations.AddArrayEnumToProduct do
  use Ecto.Migration

  def change do
    alter table(:products) do
      add :measurements, {:array, :string}
    end
  end
end
