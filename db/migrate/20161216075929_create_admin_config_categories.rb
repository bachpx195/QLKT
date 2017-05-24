class CreateAdminConfigCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :config_categories do |t|
      t.string :name
      t.string :value
      t.string :description

      t.timestamps
    end
  end
end
