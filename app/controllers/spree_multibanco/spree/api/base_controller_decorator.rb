module SpreeMultibanco::Spree::Api::BaseControllerDecorator
  def api_key
    request.headers["X-Spree-Token"] || params[:token] || params[:chave]
  end
end

::Spree::Api::BaseController.prepend(SpreeMultibanco::Spree::Api::BaseControllerDecorator)