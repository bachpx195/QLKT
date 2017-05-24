class CreateAdminFeedbacks < ActiveRecord::Migration[5.0]
  def change
    create_table :feedbacks do |t|
      t.references :user, foreign_key: true
      t.text :description

      t.timestamps
    end
  end
end
