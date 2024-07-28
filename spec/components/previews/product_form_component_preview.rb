# http://localhost:3000/rails/view_components/product_form_component/default

class ProductFormComponentPreview < ViewComponent::Preview
  def default
    product = FactoryBot.build(:product)
    render(ProductFormComponent.new(product))
  end
end
