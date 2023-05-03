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
  validates :region, :locality, :area, presence: true

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
