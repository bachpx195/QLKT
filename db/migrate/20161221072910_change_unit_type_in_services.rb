class ChangeUnitTypeInServices < ActiveRecord::Migration[5.0]
  def change
    change_column :services, :unit, :string
  end
end
