# http://localhost:3000/rails/view_components/group_of_products_component/default

class GroupOfProductsComponentPreview < ViewComponent::Preview
  def default
    date = Date.today
    products = FactoryBot.create_list(:product, 3, purchase_date: date)
    render(GroupOfProductsComponent.new(date, products))
  end
end
