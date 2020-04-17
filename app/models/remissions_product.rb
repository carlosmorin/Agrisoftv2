class RemissionsProduct < ApplicationRecord
  belongs_to :remission
  belongs_to :product
end
