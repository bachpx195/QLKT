class AddConfigCategoryToConfigs < ActiveRecord::Migration[5.0]
  def change
    add_reference :configs, :config_category, foreign_key: true
  end
end
