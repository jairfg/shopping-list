# http://localhost:3000/rails/view_components/product_card_component/default

class ProductCardComponentPreview < ViewComponent::Preview
  def default
    product = FactoryBot.create(:product)
    render(ProductCardComponent.new(product))
  end
end
