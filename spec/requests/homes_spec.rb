require 'rails_helper'

RSpec.describe "PagesController Integration", type: :request do
  describe "GET /" do
    it "When Log Out it has a home page" do
      get root_path
      expect(response).to have_http_status(200)
    end
  end

  # it "displays the user's username after successful login" do
  #   user = User.create!(:username => "jdoe", :password => "secret")
  #   get "/login"
  #   assert_select "form.login" do
  #     assert_select "input[name=?]", "username"
  #     assert_select "input[name=?]", "password"
  #     assert_select "input[type=?]", "submit"
  #   end

  #   post "/login", :username => "jdoe", :password => "secret"
  #   assert_select ".header .username", :text => "jdoe"
  # end
end
