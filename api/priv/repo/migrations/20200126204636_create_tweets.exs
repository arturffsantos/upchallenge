defmodule Api.Repo.Migrations.CreateTweets do
  use Ecto.Migration

  def change do
    create table(:tweets) do
      add :text, :string, size: 280, null: false
      add :user_id, references(:users)
      timestamps()
    end
  end
end
