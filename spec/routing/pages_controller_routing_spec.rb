require 'rails_helper'

RSpec.describe "PagesController Routing", :type => :routing do
  it "properly generates a root route to display the home page when supplying: '/'" do
    expect(:get => "/").to route_to(
      :controller => "pages",
      :action => "home"
    )
  end
end
