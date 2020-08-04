class AddCategoriesRelationsToProviders < ActiveRecord::Migration[6.0]
  def change
    add_reference :providers, :provider_category, null: false, foreign_key: true
    add_reference :providers, :subcategory, null: false, foreign_key: true
  end
end
