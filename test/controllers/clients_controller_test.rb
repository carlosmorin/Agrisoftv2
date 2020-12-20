# frozen_string_literal: true

require 'test_helper'

class ClientsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get clients_index_url
    assert_response :success
  end

  test 'should get new' do
    get clients_new_url
    assert_response :success
  end

  test 'should get create' do
    get clients_create_url
    assert_response :success
  end
end
