class Admin::Group < ApplicationRecord
  has_many :user
  has_many :group_permission
  has_many :function, through: :group_permission
  has_many :permission, through: :group_permission
end
