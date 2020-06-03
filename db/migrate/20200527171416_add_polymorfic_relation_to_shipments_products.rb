class AddPolymorficRelationToShipmentsProducts < ActiveRecord::Migration[6.0]
  def change
    add_reference :shipments_products, :productable, polymorphic: true
  end
end
