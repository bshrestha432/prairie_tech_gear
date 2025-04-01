# app/controllers/products_controller.rb
class ProductsController < ApplicationController
  def index
    products = Product.order(created_at: :desc)

    products = case params[:filter]
    when 'on_sale'
      products.where(on_sale: true)
    when 'new_arrivals'
      products.where('created_at >= ?', 3.days.ago).where(new_arrival: true)
    when 'recently_updated'
      products.where('updated_at >= ? AND (created_at < ? OR new_arrival = false)',
                    3.days.ago, 3.days.ago)
    else
      products
    end

    page = params[:page].to_i > 0 ? params[:page] : 1

    @products = products.page(page).per(12)
    @categories = Category.all.order(:name)

    session[:last_search] = params[:q] if params[:q].present?
  end
end