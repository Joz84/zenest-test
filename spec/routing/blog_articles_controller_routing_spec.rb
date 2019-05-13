require 'rails_helper'

RSpec.describe "BlogArticlesController Routing", :type => :routing do
  it "properly generates a root route to display the blog with articles index when supplying: '/blog'" do
    expect(:get => "/blog").to route_to(
      :controller => "blog_articles",
      :action => "index"
    )
  end

  it "properly generates a root route to display the blog with articles index when supplying: '/blog'" do
    expect(:get => "/blog/1").to route_to(
      :controller => "blog_articles",
      :action => "show",
      :id => "1"
    )
  end
end
