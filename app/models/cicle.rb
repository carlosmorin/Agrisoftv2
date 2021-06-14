class Cicle < ApplicationRecord
  belongs_to :crop
  belongs_to :ranch
  
  validates :name, uniqueness: true, presence: true

  has_many :cicles_areas, inverse_of: :cicle, dependent: :destroy
  accepts_nested_attributes_for :cicles_areas, allow_destroy: true

  enum status: { inactive: 0, active: 1 }

  def ranch_name
  	ranch.name
  end

  def crop_name
  	crop.name
  end
end
