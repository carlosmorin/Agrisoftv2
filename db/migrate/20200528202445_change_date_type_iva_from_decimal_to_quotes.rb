class ChangeDateTypeIvaFromDecimalToQuotes < ActiveRecord::Migration[6.0]
	def change
		change_column :quotes, :iva, :decimal
	end
end
