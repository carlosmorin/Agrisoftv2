class User < ApplicationRecord
  acts_as_paranoid
  default_scope { order(:created_at) }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  	:recoverable, :rememberable, :validatable, :trackable
  
  validates :name, :last_name, :email, presence: true

  def active_for_authentication?
    super && !deactivated
  end

  def full_name
  	"#{name} #{last_name}"
  end
end