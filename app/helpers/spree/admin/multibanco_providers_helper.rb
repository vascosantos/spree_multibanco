module Spree
  module Admin
    module MultibancoProvidersHelper

      def multibanco_provider_status(provider)
        provider.active? ? Spree.t(:active) : Spree.t(:inactive)
      end

      def action_to_toggle_multibanco_provider_status(provider)
        provider.active? ? Spree.t(:deactivate) : Spree.t(:activate)
      end

    end
  end
end