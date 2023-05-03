# == Schema Information
#
# Table name: properties
#
#  id             :integer          not null, primary key
#  area           :decimal(7, 2)
#  bathrooms      :decimal(4, 2)
#  bedrooms       :integer
#  description    :text
#  locality       :string           not null
#  price_cents    :integer          default(0), not null
#  price_currency :string           default("CLP"), not null
#  property_type  :integer          default("rent")
#  region         :string           not null
#  title          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer          not null
#
# Indexes
#
#  index_properties_on_locality   (locality)
#  index_properties_on_max_price  ("max_price")
#  index_properties_on_min_price  ("min_price")
#  index_properties_on_operation  ("operation")
#  index_properties_on_user_id    (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class Property < ApplicationRecord
  TYPES = %i[rent sale].freeze

  belongs_to :user

  has_many_attached :images

  enum :property_type, TYPES

  monetize :price_cents

  validates :price_cents, numericality: { greater_than: 0 }
  validates :area, numericality: { greater_than: 0 }
  validates :bedrooms, numericality: { greater_than: 0 }
  validates :bathrooms, numericality: { greater_than: 0 }
  validates :region, :locality, :area, :title, :description, presence: true

  validate :count_of_images

  scope :operation, ->(operation) { where(property_type: operation) }
  scope :between_prices, ->(min_price, max_price) { where(price_cents: min_price..max_price) }
  scope :locality, ->(locality) { where(locality: locality) }

  def main_image
    images.first
  end

  def self.available_localities
    Property.pluck(:locality).uniq
  end

  private

  MINIMUM_IMAGES_NUMBER = 3

  def count_of_images
    unless images.length >= MINIMUM_IMAGES_NUMBER
      errors.add(:images, "should be greater or equal than 3")
    end
  end
end
