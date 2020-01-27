defmodule Api.Repo.Migrations.CreateFollowers do
  use Ecto.Migration

  def change do
    create table(:followers, primary_key: false) do
      add(:followed, references(:users, on_delete: :delete_all), primary_key: true)
      add(:follower, references(:users, on_delete: :delete_all), primary_key: true)

      timestamps()
    end

    create(index(:followers, [:followed]))
    create(index(:followers, [:follower]))

    create(unique_index(:followers, [:followed, :follower]))
  end
end
