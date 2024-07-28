require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe 'POST #create' do
    let(:store_section) { create(:store_section) }
    let(:valid_attributes) { attributes_for(:product, store_section_id: store_section.id) }
    let(:invalid_attributes) { attributes_for(:product, name: '') }

    context 'with valid attributes' do
      it 'creates a new product and returns a successful response' do
        expect {
          post :create, params: { product: valid_attributes }, format: :turbo_stream
        }.to change(Product, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(response).to render_template('products/_create_product')
      end

      it 'renders create_product' do
        post :create, params: { product: valid_attributes }, format: :turbo_stream
        expect(response).to render_template('products/_create_product')
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new product and returns an unprocessable status' do
        expect {
          post :create, params: { product: invalid_attributes }, format: :turbo_stream
        }.not_to change(Product, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'renders show_message turbo stream' do
        post :create, params: { product: invalid_attributes }, format: :turbo_stream
        expect(response).to render_template('products/_show_message')
      end
    end
  end

  describe 'PUT #check_purchased' do
    let(:product) { create(:product) }

    context 'when check_purchased is successful' do
      it 'returns a successful response' do
        put :check_purchased, params: { id: product.id, product: { purchased: true } }, format: :turbo_stream
        expect(response).to have_http_status(:ok)
      end

      it 'renders check_purchased turbo stream' do
        put :check_purchased, params: { id: product.id, product: { purchased: true } }, format: :turbo_stream
        expect(response).to render_template('products/_check_purchased')
      end
    end

    context 'when check_purchased fails' do
      before do
        allow_any_instance_of(Product).to receive(:update).and_return(false)
      end

      it 'returns unprocessable status' do
        put :check_purchased, params: { id: product.id, product: { purchased: true } }, format: :turbo_stream
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'renders show_message turbo stream' do
        put :check_purchased, params: { id: product.id, product: { purchased: true } }, format: :turbo_stream
        expect(response).to render_template('products/_show_message')
      end
    end
  end
end
