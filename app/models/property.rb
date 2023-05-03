class Property < ApplicationRecord
  TYPES = %i[rent sale].freeze

  has_many_attached :images

  enum :property_type, TYPES

  monetize :price_cents

  validates :price_cents, numericality: { greater_than: 0 }
  validates :area, numericality: { greater_than: 0 }
  validates :bedrooms, numericality: { greater_than: 0 }
  validates :bathrooms, numericality: { greater_than: 0 }
  validates :region, :locality, :area, presence: true

  validate :count_of_images

  private

  MINIMUM_IMAGES_NUMBER = 3

  def count_of_images
    unless images.length >= MINIMUM_IMAGES_NUMBER
      errors.add(:images, "should be greater or equal than 3")
    end
  end
end
