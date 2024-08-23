class OrderMailer < ApplicationMailer
    default from: 'no-reply@mic.com'
  
    # Méthode pour envoyer la confirmation de commande
    def order_confirmation(order)
      @order = order
      mail(
        to: @order.user.email,
        subject: 'Confirmation de votre commande'
      )
    end
  end
  