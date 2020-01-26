defmodule Api.V1Test do
  use Api.DataCase

  alias Api.V1

  describe "users" do
    alias Api.V1.User

    @valid_attrs %{email: "some email", password_hash: "some password_hash", user_name: "some user_name"}
    @update_attrs %{email: "some updated email", password_hash: "some updated password_hash", user_name: "some updated user_name"}
    @invalid_attrs %{email: nil, password_hash: nil, user_name: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> V1.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert V1.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert V1.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = V1.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.password_hash == "some password_hash"
      assert user.user_name == "some user_name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = V1.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = V1.update_user(user, @update_attrs)
      assert user.email == "some updated email"
      assert user.password_hash == "some updated password_hash"
      assert user.user_name == "some updated user_name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = V1.update_user(user, @invalid_attrs)
      assert user == V1.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = V1.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> V1.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = V1.change_user(user)
    end
  end
end
