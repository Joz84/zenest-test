require 'rails_helper'

RSpec.describe "BlogArticlesController Integration", type: :request do
  describe "GET /blog#index" do
    it "When go to blog it display a page" do
      get "/blog"
      expect(response).to have_http_status(200)
    end
  end
    describe "GET /blog#show" do
    it "When go to blog it display a page" do
      get "/blog/1"
      expect(response).to have_http_status(200)
    end
  end
end
