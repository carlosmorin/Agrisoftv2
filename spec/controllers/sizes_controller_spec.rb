require 'rails_helper'
require 'pry'
RSpec.describe SizesController, type: :controller do
	login_user

	let(:valid_attributes) {
   { name: "Hola", short_name: "This is a test description" }
  }

  describe "GET #index" do
    it "returns a success response" do 
    	2.times do
      	size = create(:size)
    	end
      get :index
      expect(response).to be_successful
      expect(Size.all.size).to eq(2)
    end
	end
end