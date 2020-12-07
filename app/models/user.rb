class User < ApplicationRecord
  acts_as_paranoid
  default_scope { order(:created_at) }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  	:recoverable, :rememberable, :validatable, :trackable
  
  validates :name, :last_name, :email, presence: true
  validates_uniqueness_of :email
  has_many :shipments, inverse_of: :user
  has_many :quotes, inverse_of: :user
  has_many :bills, inverse_of: :user
  has_one_attached :avatar
  
  def active_for_authentication?
    super && !deactivated
  end

  def full_name
  	"#{name} #{last_name}".upcase
  end
end