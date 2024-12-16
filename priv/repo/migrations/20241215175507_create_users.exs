defmodule Crud.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :age, :integer
      add :email, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:users, [:email])
  end
end
