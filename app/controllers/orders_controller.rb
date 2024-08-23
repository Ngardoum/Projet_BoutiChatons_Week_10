class OrdersController < ApplicationController
  before_action :authenticate_user!

  def new
    @order = Order.new
  end

  def create
    @order = current_user.orders.new(order_params)
    @order.cart_items = current_user.cart.cart_items

    if @order.save
      begin
        # Calculer le montant total du panier
        amount = (current_user.cart.cart_items.sum { |item| item.quantity * item.price } * 100).to_i

        # Créer la charge Stripe
        charge = Stripe::Charge.create(
          amount: amount,
          currency: 'usd',
          description: 'Purchase from MyEcommerceSite',
          source: params[:stripeToken]
        )

        # Nettoyer le panier seulement si le paiement est réussi
        current_user.cart.cart_items.destroy_all

        # Envoyer l'email de confirmation
        OrderMailer.with(order: @order).order_confirmation.deliver_later

        # Rediriger vers la page d'accueil avec un message de succès
        redirect_to root_path, notice: 'Merci pour votre achat !'
      rescue Stripe::CardError => e
        # Gérer les erreurs Stripe
        flash[:error] = e.message
        redirect_to new_order_path
      end
    else
      # Si la commande n'est pas sauvée, réafficher le formulaire de commande avec les erreurs
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:stripeToken) # Ajuste les paramètres ici si tu as d'autres attributs pour une commande
  end
end
