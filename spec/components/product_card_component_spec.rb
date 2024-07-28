# frozen_string_literal: true
require "rails_helper"

RSpec.describe ProductCardComponent, type: :component do
  let(:product) { create(:product) }

  it 'renders product card component' do
    render_inline(ProductCardComponent.new(product))

    expect(page).to have_css('tr', count: 1)
    expect(page).to have_content(product.store_name)
    expect(page).to have_content(product.store_section.name)
    expect(page).to have_content(product.name)
    expect(page).to have_content(product.quantity)
    expect(page).to have_field('completed', checked: product.purchased)
  end
end
