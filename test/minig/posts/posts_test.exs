defmodule Minig.PostsTest do
  use Minig.DataCase, async: true

  alias Minig.Post
  alias Minig.Posts

  describe "exists?/1" do
    test "returns true when post exists" do
      %{id: id} = Factory.insert(:post)

      assert Posts.exists?(id)
    end

    test "returns false when post doesn't exists" do
      refute Posts.exists?(900)
    end
  end

  describe "create/4" do
    test "create a post with valid params" do
      %{id: customer_id} = Factory.insert(:customer)

      assert {:ok, %Post{}} =
               Posts.create("as13fssdf==?123", "image/jpeg", "Sunny day!", customer_id)
    end

    test "error with invalid customer_id" do
      assert {:error, %{errors: [customer_id: {"does not exist", _}]}} =
               Posts.create("as13fssdf==?123", "image/jpeg", "Sunny day!", 900)
    end
  end

  describe "get/1" do
    test "get all posts" do
      %{id: id1} = Factory.insert(:post)
      %{id: id2} = Factory.insert(:post)
      %{id: id3} = Factory.insert(:post)

      assert [%Post{id: ^id1}, %Post{id: ^id2}, %Post{id: ^id3}] = Posts.get()
    end
  end

  describe "by_customer/2" do
    test "get all posts from specific customer" do
      %{id: customer_id} = customer = Factory.insert(:customer)
      %{id: id} = Factory.insert(:post, customer: customer)
      Factory.insert(:post)

      assert [%Post{id: ^id}] = Posts.by_customer(customer_id)
    end
  end

  describe "like/2" do
    test "add a like with right params" do
      %{id: customer_id} = customer = Factory.insert(:customer)
      %{id: post_id} = post = Factory.insert(:post, customer: customer)

      assert %Post{likes: 0, customer_likes: []} = post
      assert {:ok, %Post{}} = Posts.like(post_id, customer_id)

      assert %Post{likes: 1, customer_likes: [^customer_id]} = Repo.get(Post, post_id)
    end

    test "don't add a like if the customer already liked" do
      %{id: customer_id} = customer = Factory.insert(:customer)

      %{id: post_id} =
        post = Factory.insert(:post, likes: 1, customer_likes: [customer_id], customer: customer)

      assert %Post{likes: 1, customer_likes: [^customer_id]} = post
      assert {:ok, %Post{}} = Posts.like(post_id, customer_id)

      assert %Post{likes: 1, customer_likes: [^customer_id]} = Repo.get(Post, post_id)
    end
  end
end
