defmodule Friends.Comment do
  use Ecto.Schema

  import Ecto.Changeset

  alias Friends.User

  @primary_key false

  schema "user_comments" do
    field(:key_id, :binary_id, primary_key: true)
    field(:value, :string)
    belongs_to(:user, User, type: :binary_id, primary_key: true)
    timestamps()
  end

  def changeset(person, params \\ %{}) do
    person
    |> cast(params, [:key_id, :value])
    |> validate_required([:key_id])
  end
end
