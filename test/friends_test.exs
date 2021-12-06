defmodule FriendsTest do
  use ExUnit.Case
  use ExMachina.Ecto, repo: Friends.Repo

  import Ecto.Query

  alias Friends.Comment
  alias Friends.User
  alias Friends.Repo

  test "greets the world" do
    key1 = Ecto.UUID.generate()
    id1 = Ecto.UUID.generate()

    key2 = Ecto.UUID.generate()
    id2 = Ecto.UUID.generate()

    user =
      insert(:user,
        name: "John",
        comments: [
          %Comment{key_id: key1},
          %Comment{key_id: key2}
        ]
      )

    params = %{
      comments: [
        %{key_id: key1, value: "foo", user_id: user.id},
        %{key_id: key2, user_id: user.id}
      ]
    }

    Friends.User.update_changeset(user, params)
    |> IO.inspect(label: "====>>>> 24 ", pretty: true, limit: :infinity)
    |> Repo.update!()

    User
    |> Ecto.Query.first()
    |> preload(:comments)
    |> Repo.one!()
    |> IO.inspect(label: "====>>>> 42 ", pretty: true, limit: :infinity)
  end

  def user_factory do
    %Friends.User{
      name: "Jane Smith"
    }
  end

  def comment_factory do
    %Friends.Comment{}
  end
end
