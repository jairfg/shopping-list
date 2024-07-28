# frozen_string_literal: true

class ProductCardComponent < ViewComponent::Base
  def initialize(product)
    @product = product
  end

  def render
    render(ProductCardComponent.new(@product))
  end
end
