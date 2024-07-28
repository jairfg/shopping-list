class ProductsController < ApplicationController
  before_action :set_product, only: %i[check_purchased]

  def index
    @product = Product.new
    @hash_date_products = Product.hash_date_products
  end

  def create
    @product = Product.new(product_params)
    respond_to do |format|
      new_date = !Product.pending_purchase?(@product.purchase_date)

      if @product.save
        @hash_date_products = Product.hash_date_products if new_date
        format.turbo_stream {
          render partial: 'products/create_product',
                 status: :created,
                 locals: { product: @product, new_date: }
        }
      else
        format.turbo_stream {
          render partial: 'products/show_message',
                 status: :unprocessable_entity,
                 locals: { product: @product }
        }
      end
    end
  end

  def check_purchased
    respond_to do |format|
      if @product.update(product_params)
        pending_purchase_for_date = Product.pending_purchase?(@product.purchase_date)
        format.turbo_stream {
          render partial: 'products/check_purchased',
                 status: :ok,
                 locals: { product: @product, pending_purchase_for_date: }
        }
      else
        format.turbo_stream {
          render partial: 'products/show_message',
                 status: :unprocessable_entity,
                 locals: { product: @product }
        }
      end
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :store_section_id, :store_name, :purchased, :purchase_date, :quantity)
  end
end
