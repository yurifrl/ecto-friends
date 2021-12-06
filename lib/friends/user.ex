defmodule Friends.User do
  use Ecto.Schema

  import Ecto.Query
  import Ecto.Changeset

  alias Friends.Comment
  alias Friends.Repo

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "users" do
    field(:name, :string)
    has_many(:comments, Comment)
    timestamps()
  end

  def update_changeset(struct, params) do
    params |> IO.inspect(label: "====>>>> 19 ", pretty: true, limit: :infinity)

    struct
    |> Repo.preload(:comments)
    |> cast(params, [:name])
    |> cast_assoc(:comments)
  end
end
