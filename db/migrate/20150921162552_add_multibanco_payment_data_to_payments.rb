class AddMultibancoPaymentDataToPayments < ActiveRecord::Migration
  def change
  	add_column :spree_payments, :multibanco_provider_name, :string
  	add_column :spree_payments, :multibanco_entity, :string
  	add_column :spree_payments, :multibanco_subentity, :string
  	add_column :spree_payments, :multibanco_reference, :string
  end
end
