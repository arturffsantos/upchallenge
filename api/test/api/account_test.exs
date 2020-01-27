defmodule Api.AccountTest do
  use Api.DataCase

  alias Api.Account

  describe "users" do
    alias Api.Account.User

    @valid_attrs %{
      email: "some email",
      password_hash: "some password_hash",
      user_name: "some user_name"
    }
    @update_attrs %{
      email: "some updated email",
      password_hash: "some updated password_hash",
      user_name: "some updated user_name"
    }
    @invalid_attrs %{email: nil, password_hash: nil, user_name: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Account.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Account.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Account.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Account.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.password_hash == "some password_hash"
      assert user.user_name == "some user_name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Account.update_user(user, @update_attrs)
      assert user.email == "some updated email"
      assert user.password_hash == "some updated password_hash"
      assert user.user_name == "some updated user_name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Account.update_user(user, @invalid_attrs)
      assert user == Account.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Account.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Account.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Account.change_user(user)
    end
  end

  describe "followers" do
    alias Api.Account.Follower

    @valid_attrs %{followed: 42, follower: 42}
    @update_attrs %{followed: 43, follower: 43}
    @invalid_attrs %{followed: nil, follower: nil}

    def follower_fixture(attrs \\ %{}) do
      {:ok, follower} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Account.create_follower()

      follower
    end

    test "list_followers/0 returns all followers" do
      follower = follower_fixture()
      assert Account.list_followers() == [follower]
    end

    test "get_follower!/1 returns the follower with given id" do
      follower = follower_fixture()
      assert Account.get_follower!(follower.id) == follower
    end

    test "create_follower/1 with valid data creates a follower" do
      assert {:ok, %Follower{} = follower} = Account.create_follower(@valid_attrs)
      assert follower.followed == 42
      assert follower.follower == 42
    end

    test "create_follower/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_follower(@invalid_attrs)
    end

    test "update_follower/2 with valid data updates the follower" do
      follower = follower_fixture()
      assert {:ok, %Follower{} = follower} = Account.update_follower(follower, @update_attrs)
      assert follower.followed == 43
      assert follower.follower == 43
    end

    test "update_follower/2 with invalid data returns error changeset" do
      follower = follower_fixture()
      assert {:error, %Ecto.Changeset{}} = Account.update_follower(follower, @invalid_attrs)
      assert follower == Account.get_follower!(follower.id)
    end

    test "delete_follower/1 deletes the follower" do
      follower = follower_fixture()
      assert {:ok, %Follower{}} = Account.delete_follower(follower)
      assert_raise Ecto.NoResultsError, fn -> Account.get_follower!(follower.id) end
    end

    test "change_follower/1 returns a follower changeset" do
      follower = follower_fixture()
      assert %Ecto.Changeset{} = Account.change_follower(follower)
    end
  end
end
