Spree::Api::BaseController.class_eval do 
  def api_key
    request.headers["X-Spree-Token"] || params[:token] || params[:chave]
  end
end