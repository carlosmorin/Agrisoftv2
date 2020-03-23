class User < ApplicationRecord
  default_scope { order(:created_at) }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  	:recoverable, :rememberable, :validatable, :trackable
  
  validates :email, :password, presence: true

  def full_name
  	"#{name} #{last_name}"
  end
end
