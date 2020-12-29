# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SizesController, type: :controller do
  describe 'GET #index' do
    login_user
    it 'returns a success response' do
      2.times do
        size = create(:size)
      end
      get :index
      expect(response).to be_successful
      expect(Size.all.size).to eq(2)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'POST create' do
    context 'with valid attributes' do
      it 'creates a new size' do
        expect { post :create, size: :size }
      end
    end
  end
end
