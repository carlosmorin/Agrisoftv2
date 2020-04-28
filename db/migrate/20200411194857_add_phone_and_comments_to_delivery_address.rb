class AddPhoneAndCommentsToDeliveryAddress < ActiveRecord::Migration[6.0]
  def change
    add_column :delivery_addresses, :phone, :string
    add_column :delivery_addresses, :comments, :text
  end
end
