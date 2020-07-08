require 'rails_helper'

RSpec.describe SizesController, type: :controller do
	let(:valid_attributes) {
   { name: "Test title!", short_name: "This is a test description" }
  }

  describe "GET #index" do
    it "returns a success response" do
      Size.create! valid_attributes
      get :index
      expect(response).to be_successful
    end
	end
end