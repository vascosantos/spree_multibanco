module Spree
  class MultibancoProvider < ActiveRecord::Base
    validates :name, :entity, :subentity, presence: true
    validates_uniqueness_of :subentity, scope: :entity

    scope :active, -> { where(active: true) }
  end
end
