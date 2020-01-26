defmodule Api.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :password_hash, :string
      add :user_name, :string

      timestamps()
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:user_name])
  end
end
