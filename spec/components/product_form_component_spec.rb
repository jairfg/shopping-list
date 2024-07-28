require 'rails_helper'

RSpec.describe ProductFormComponent, type: :component do
  let(:product) { build(:product) }

  it 'renders product form component' do
    render_inline(ProductFormComponent.new(product))
    expect(page).to have_css('.form-container')
    expect(page).to have_selector("div#message")
    expect(page).to have_field('product_name', type: 'text', with: product.name)
    expect(page).to have_field('product_store_name', type: 'textarea', with: product.store_name)
    expect(page).to have_field('product_quantity', type: 'number', with: product.quantity.to_s)
    expect(page).to have_select('product_store_section_id', with_options: ['Select Store Section'])
    expect(page).to have_field('product_purchase_date', type: 'date', with: product.purchase_date.to_s)

    expect(page).to have_button('Save')
  end
end
