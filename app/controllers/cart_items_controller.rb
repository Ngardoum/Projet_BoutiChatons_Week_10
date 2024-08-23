class CartItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart_item, only: [:destroy, :update]

  def create
    product = Product.find(params[:product_id])
    @cart = current_user.cart
    @cart_item = @cart.cart_items.find_or_initialize_by(product: product)
    
    # Initialiser la quantité à 0 si elle est nil
    @cart_item.quantity = (@cart_item.quantity || 0) + params[:quantity].to_i
    
    if @cart_item.save
      redirect_to cart_path, notice: 'Produit ajouté au panier.'
    else
      redirect_to product_path(product), alert: 'Impossible d\'ajouter le produit au panier.'
    end
  end

  def destroy
    @cart_item.destroy
    redirect_to cart_path, notice: 'Produit retiré du panier.'
  end

  def update
    if @cart_item.update(cart_item_params)
      redirect_to cart_path, notice: 'Quantité mise à jour.'
    else
      redirect_to cart_path, alert: 'Impossible de mettre à jour la quantité.'
    end
  end

  private

  # Méthode de callback pour DRY
  def set_cart_item
    @cart_item = current_user.cart.cart_items.find(params[:id])
  end

  # Strong parameters
  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end
end
