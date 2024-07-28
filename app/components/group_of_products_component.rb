# frozen_string_literal: true

class GroupOfProductsComponent < ViewComponent::Base
  def initialize(date, products)
    @date = date
    @products = products
  end
end
