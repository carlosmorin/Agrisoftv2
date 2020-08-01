class Subcategory < ApplicationRecord
  belongs_to :categorytable, polymorphic: true
  validates :name, presence: true
end
