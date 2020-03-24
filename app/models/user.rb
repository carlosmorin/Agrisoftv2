class User < ApplicationRecord
  default_scope { order(:created_at) }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  	:recoverable, :rememberable, :validatable, :trackable
  
  validates :email, :password, presence: true
  has_many :general_informations
  accepts_nested_attributes_for :general_informations
end
