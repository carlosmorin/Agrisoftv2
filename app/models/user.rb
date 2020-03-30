class User < ApplicationRecord
  default_scope { order(:created_at) }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  	:recoverable, :rememberable, :validatable, :trackable
  
  validates :name, :last_name, :email, :password, presence: true

  def active_for_authentication?
    super && !deactivated
  end

  def full_name
  	"#{name} #{last_name}"
  end
  
  def destroy
    update_attributes(deactivated: true) unless deactivated
  end
end

