class ApplicationController < ActionController::Base
    before_action :set_cart

  private

  def set_cart
    @cart = Cart.find_or_create_by(user_id: current_user.id) # ou selon votre logique d'authentification
  end
end
