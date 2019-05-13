require 'test_helper'

class BlogArticlesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get blog_articles_index_url
    assert_response :success
  end

  test "should get show" do
    get blog_articles_show_url
    assert_response :success
  end

end
