class CreateBankAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :bank_accounts do |t|
      t.references :bank, null: false, foreign_key: true
      t.references :currency, null: false, foreign_key: true
      t.string :name
      t.string :titular
      t.string :bank_key
      t.string :account_number
      t.string :card_number
      t.string :branch
      t.references :accountable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
