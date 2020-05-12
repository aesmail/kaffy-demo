defmodule Bakery.Repo.Migrations.AddDescriptionToProduct do
  use Ecto.Migration

  def change do
    alter table(:products) do
      add :description, :text
    end
  end
end
