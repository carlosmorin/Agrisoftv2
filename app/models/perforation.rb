class Perforation < ApplicationRecord
  belongs_to :ranch
  validates :name, :coordinates, :registry_number, :volume, :validity, :expenditure, presence: true
end
