class User < ApplicationRecord
  default_scope { order(:created_at) }
  
  validates :name, :last_name, :email, :phone, presence: true

  def full_name
  	"#{name} #{last_name}"
  end
end
