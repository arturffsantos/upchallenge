defmodule Api.Repo.Migrations.CreateFollowers do
  use Ecto.Migration

  def change do
    create table(:followers, primary_key: false) do
      add(:followed_id, references(:users, on_delete: :delete_all), primary_key: true)
      add(:follower_id, references(:users, on_delete: :delete_all), primary_key: true)

      timestamps()
    end

    create(index(:followers, [:followed_id]))
    create(index(:followers, [:follower_id]))

    create(unique_index(:followers, [:followed_id, :follower_id]))
  end
end
