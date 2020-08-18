module SpreeMultibanco::Spree
  module Admin
    class MultibancoProvidersController < ResourceController
      def index
        @search = Spree::MultibancoProvider.ransack(params[:q])
        @multibanco_providers = @search.result.page(params[:page])
      end

      def toggle_activation
        @success = @multibanco_provider.toggle!(:active)
      end
    end
  end
end
