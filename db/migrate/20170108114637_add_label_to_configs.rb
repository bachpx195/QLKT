class AddLabelToConfigs < ActiveRecord::Migration[5.0]
  def change
    add_column :configs, :label, :string
  end
end
