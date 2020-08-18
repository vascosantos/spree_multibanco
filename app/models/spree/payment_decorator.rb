module Spree::PaymentDecorator
  attr_accessor :validate_multibanco_details

  def self.prepended(base)
    base.before_create :generate_multibanco_reference
    base.belongs_to :multibanco_provider
    base.validates :multibanco_provider_name, :multibanco_entity, :multibanco_subentity, :multibanco_reference, :presence => true, :if => :validate_multibanco_details
    base.scope :from_multibanco, -> { joins(:payment_method).where(:spree_payment_methods => { :type => 'Spree::PaymentMethod::Multibanco' }) }
  end

  def generate_multibanco_reference
    if self.payment_method.type == 'Spree::PaymentMethod::Multibanco' && Spree::MultibancoProvider.active.any?
      self.multibanco_provider = Spree::MultibancoProvider.active.first

      entity = self.multibanco_provider.entity
      subentity = self.multibanco_provider.subentity
      sequence = self.order_id
      amount_cents = Spree::Money.new(self.amount).cents

      entity_str = ("%05d" % (entity))[-5,5]
      subentity_str = ("%03d" % (subentity))[-3,3]
      sequence_str = ("%04d" % (sequence))[-4,4]
      amount_str = ("%08d" % (amount_cents))[-8,8]
      
      digit_str = "#{entity_str}#{subentity_str}#{sequence_str}#{amount_str}"

      accum = 0
      [51, 73, 17, 89, 38, 62, 45, 53, 15, 50, 5, 49, 34, 81, 76, 27, 90, 9, 30, 3].each_with_index do |coeff, k|
        accum += coeff * digit_str[k].to_i
      end
      checksum = 98 - (accum % 97)

      checksum_str = ("%02d" % (checksum))[-2,2]

      self.multibanco_reference = "#{subentity_str}#{sequence_str}#{checksum_str}"
    end
  end
end

::Spree::Payment.prepend(Spree::PaymentDecorator)