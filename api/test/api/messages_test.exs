defmodule Api.MessagesTest do
  use Api.DataCase

  alias Api.Messages

  describe "tweets" do
    alias Api.Messages.Tweet

    @valid_attrs %{text: "some text"}
    @update_attrs %{text: "some updated text"}
    @invalid_attrs %{text: nil}

    def tweet_fixture(attrs \\ %{}) do
      {:ok, tweet} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Messages.create_tweet()

      tweet
    end

    test "list_tweets/0 returns all tweets" do
      tweet = tweet_fixture()
      assert Messages.list_tweets() == [tweet]
    end

    test "get_tweet!/1 returns the tweet with given id" do
      tweet = tweet_fixture()
      assert Messages.get_tweet!(tweet.id) == tweet
    end

    test "create_tweet/1 with valid data creates a tweet" do
      assert {:ok, %Tweet{} = tweet} = Messages.create_tweet(@valid_attrs)
      assert tweet.text == "some text"
    end

    test "create_tweet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Messages.create_tweet(@invalid_attrs)
    end

    test "update_tweet/2 with valid data updates the tweet" do
      tweet = tweet_fixture()
      assert {:ok, %Tweet{} = tweet} = Messages.update_tweet(tweet, @update_attrs)
      assert tweet.text == "some updated text"
    end

    test "update_tweet/2 with invalid data returns error changeset" do
      tweet = tweet_fixture()
      assert {:error, %Ecto.Changeset{}} = Messages.update_tweet(tweet, @invalid_attrs)
      assert tweet == Messages.get_tweet!(tweet.id)
    end

    test "delete_tweet/1 deletes the tweet" do
      tweet = tweet_fixture()
      assert {:ok, %Tweet{}} = Messages.delete_tweet(tweet)
      assert_raise Ecto.NoResultsError, fn -> Messages.get_tweet!(tweet.id) end
    end

    test "change_tweet/1 returns a tweet changeset" do
      tweet = tweet_fixture()
      assert %Ecto.Changeset{} = Messages.change_tweet(tweet)
    end
  end

  describe "likes" do
    alias Api.Messages.Like

    @valid_attrs %{tweet_id: 42, user_id: 42}
    @update_attrs %{tweet_id: 43, user_id: 43}
    @invalid_attrs %{tweet_id: nil, user_id: nil}

    def like_fixture(attrs \\ %{}) do
      {:ok, like} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Messages.create_like()

      like
    end

    test "list_likes/0 returns all likes" do
      like = like_fixture()
      assert Messages.list_likes() == [like]
    end

    test "get_like!/1 returns the like with given id" do
      like = like_fixture()
      assert Messages.get_like!(like.id) == like
    end

    test "create_like/1 with valid data creates a like" do
      assert {:ok, %Like{} = like} = Messages.create_like(@valid_attrs)
      assert like.tweet_id == 42
      assert like.user_id == 42
    end

    test "create_like/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Messages.create_like(@invalid_attrs)
    end

    test "update_like/2 with valid data updates the like" do
      like = like_fixture()
      assert {:ok, %Like{} = like} = Messages.update_like(like, @update_attrs)
      assert like.tweet_id == 43
      assert like.user_id == 43
    end

    test "update_like/2 with invalid data returns error changeset" do
      like = like_fixture()
      assert {:error, %Ecto.Changeset{}} = Messages.update_like(like, @invalid_attrs)
      assert like == Messages.get_like!(like.id)
    end

    test "delete_like/1 deletes the like" do
      like = like_fixture()
      assert {:ok, %Like{}} = Messages.delete_like(like)
      assert_raise Ecto.NoResultsError, fn -> Messages.get_like!(like.id) end
    end

    test "change_like/1 returns a like changeset" do
      like = like_fixture()
      assert %Ecto.Changeset{} = Messages.change_like(like)
    end
  end
end
