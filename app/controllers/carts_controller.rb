class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart, only: [:show]

  def show
    @cart_items = @cart.cart_items.includes(:product)
  end

  private

  def set_cart
    @cart = current_user.cart
  end
end
