class CreateAdminGroupPermissions < ActiveRecord::Migration[5.0]
  def change
    create_table :group_permissions do |t|
      t.references :group, foreign_key: true
      t.references :function, foreign_key: true
      t.references :permission, foreign_key: true

      t.timestamps
    end
  end
end
