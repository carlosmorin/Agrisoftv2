require 'rails_helper'

RSpec.describe SizesController, type: :controller do

  describe "GET #index" do
		login_user
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