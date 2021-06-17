require "test_helper"

class CreateArticleTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  setup do
    @user = User.create(username: "bob", email: "bob@gmail.com",
      password: "password")
    sign_in_as(@user)
  end

  test "Should create new article " do
    get new_article_path
    assert_response :success
    assert_difference 'Article.count', 1 do 
      post articles_path, params: {article: {title: "a title", 
        description: "a description", category_ids: []}}
      assert_response :redirect
    end

    follow_redirect!
    assert_response :success
  end
end
