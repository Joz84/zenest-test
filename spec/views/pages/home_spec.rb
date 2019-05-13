require 'rails_helper'

# describe 'products/show.html.erb' do
#   it 'displays product details correctly' do
#     assign(:product, Product.create(name: 'Shirt', price: 50.0))

#     render

#     rendered.should contain('Shirt')
#     rendered.should contain('50.0')
#   end
# end


RSpec.describe "pages/home", :type => :view do
  it "include customer needed data on Massage" do
    render
    expect(rendered).to match("Massage Assis")
  end

  it "include Massage Category Sophrologie" do
    render
    expect(rendered).to match("Sophrologie")
  end

end
