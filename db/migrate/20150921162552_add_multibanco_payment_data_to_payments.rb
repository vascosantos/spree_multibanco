class AddMultibancoPaymentDataToPayments < ActiveRecord::Migration
  def change
  	add_column :spree_payments, :multibanco_provider_id, :integer
  	add_column :spree_payments, :multibanco_reference, :string
  end
end
