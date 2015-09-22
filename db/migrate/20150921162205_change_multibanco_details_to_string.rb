class ChangeMultibancoDetailsToString < ActiveRecord::Migration
  def change
  	change_column :spree_multibanco_providers, :entity, :string
  	change_column :spree_multibanco_providers, :subentity, :string
  end
end
