defmodule Bakery.Repo.Migrations.AddNotesToProduct do
  use Ecto.Migration

  def change do
    alter table(:products) do
      add :notes, {:array, :string}
    end
  end
end
