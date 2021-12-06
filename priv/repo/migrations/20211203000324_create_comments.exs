defmodule Friends.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:user_comments, primary_key: false) do
      add(:key_id, :binary_id, primary_key: true)
      add(:value, :string)
      add(:user_id, references(:users, type: :binary_id), null: false, primary_key: true)
      timestamps()
    end
    create(unique_index(:user_comments, [:key_id, :user_id]))
  end
end
