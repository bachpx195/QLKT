class AddCodeAndTypeToServices < ActiveRecord::Migration[5.0]
  def change
    add_column :services, :code, :string
    add_column :services, :service_type, :integer
  end
end
