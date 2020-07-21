require 'rails_helper'

RSpec.describe Size, type: :model do
  it { should have_many :crops_sizes }
  it { should have_many :crops }
  it { should have_many :products }

  it { should validate_presence_of :name }
end
