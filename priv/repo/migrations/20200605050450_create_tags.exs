defmodule Bakery.Repo.Migrations.CreateTags do
  use Ecto.Migration

  def change do
    create table(:tags) do
      add :name, :string
      add :slug, :string
      add :status, :string

      timestamps()
    end

  end
end
