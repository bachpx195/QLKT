class Admin::Function < ApplicationRecord

  has_many :group_permission
  has_many :group, through: :group_permission
  has_many :permission, through: :group_permission
end
