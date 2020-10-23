class AddCodeFromSatCfdiUsages < ActiveRecord::Migration[6.0]
  def change
  	rename_column :sat_cfdi_usages, :descripcion, :description
  	add_column :sat_cfdi_usages, :code, :string
  end
end
