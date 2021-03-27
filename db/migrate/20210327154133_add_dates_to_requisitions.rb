class AddDatesToRequisitions < ActiveRecord::Migration[6.0]
  def change
    add_column :requisitions, :unauthorized_at, :datetime
    add_column :requisitions, :authorized_at, :datetime
    add_column :requisitions, :expired_at, :datetime
    add_column :requisitions, :canceled_at, :datetime
  end
end
