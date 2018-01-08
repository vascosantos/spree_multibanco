Spree::Api::PaymentsController.class_eval do 

  skip_before_action :find_order, only: [:capture_mb_payment]

  # before_action :find_mb_order_and_payment, only: [:capture_mb_payment]

  def capture_mb_payment
    find_mb_order_and_payment
    if @payment && params[:referencia] == @payment.multibanco_reference && params[:valor].to_d == @payment.amount && params[:entidade] == @multibanco_provider.entity
      @order.resume! if @order.state == "canceled"
      capture
      @order.send_paid_email if @order.respond_to?(:send_paid_email)
    else
      not_found
    end
  end

  private

    def find_mb_order_and_payment
      @payment = Spree::Payment.where(multibanco_reference: params[:referencia], amount: params[:valor].to_d, state: ['pending', 'checkout']).last
      if @payment
        @multibanco_provider = @payment.multibanco_provider
        @order = @payment.order
        authorize! :read, @order, order_token
      end
    end
end