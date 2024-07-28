# frozen_string_literal: true
require "rails_helper"

RSpec.describe GroupOfProductsComponent, type: :component do
  let(:date) { Date.today }
  let(:products) { create_list(:product, 3, purchase_date: date) }

  it 'renders group of products component' do
    render_inline(GroupOfProductsComponent.new(date, products))

    expect(page).to have_selector('div', id: date.to_s)
    expect(page).to have_selector('h3', text: date.strftime('%A, %d de %B de %Y'))
    expect(page).to have_selector('table.product-table')
    expect(page).to have_selector('thead th', text: 'Store name')
    expect(page).to have_selector('thead th', text: 'Store section')
    expect(page).to have_selector('thead th', text: 'Product')
    expect(page).to have_selector('thead th', text: 'Quantity')
    expect(page).to have_selector('thead th', text: 'Purchased')
    expect(page).to have_selector("tbody#body-#{date}")

    products.each do |product|
      expect(page).to have_content(product.store_name)
      expect(page).to have_content(product.store_section.name)
      expect(page).to have_content(product.name)
      expect(page).to have_content(product.quantity)
    end
  end
end
