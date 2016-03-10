Deface::Override.new(
  :virtual_path => 'spree/admin/shared/sub_menu/_configuration',
  :name => 'add_multibanco_providers_to_admin_configuration_sidebar',
  :insert_bottom => "[data-hook='admin_configurations_sidebar_menu']",
  :text => %q{
    <%= configurations_sidebar_menu_item(Spree.t(:multibanco_settings), spree.admin_multibanco_providers_path) if can? :manage, Spree::PaymentMethod %>
    }
)