Spree::Api::PaymentsController.class_eval do 

  skip_before_action :find_order, only: [:capture_mb_payment]

  # before_action :find_mb_order_and_payment, only: [:capture_mb_payment]

  def capture_mb_payment
    find_mb_order_and_payment
    if @payment && params[:referencia] == @payment.multibanco_reference && params[:valor].to_d == @payment.amount && params[:entidade] == @multibanco_provider.entity
      @order.resume! if @order.state == "canceled"
      capture
      if Spree::Config.has_preference?(:automatic_invoices) && Spree::Config[:automatic_invoices]
        ## Create invoice and send paid email
        if defined?(NewCreateInvoiceJob) == 'constant' && NewCreateInvoiceJob.class == Class  
          NewCreateInvoiceJob.perform_later(@order) { @order.send_paid_email if @order.respond_to?(:send_paid_email) }
        else
          ## Only send paid email
          @order.send_paid_email if @order.respond_to?(:send_paid_email)
        end
      else
        ## Only send paid email
        @order.send_paid_email if @order.respond_to?(:send_paid_email)
      end
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