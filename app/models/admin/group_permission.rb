class Admin::GroupPermission < ApplicationRecord
  belongs_to :group
  belongs_to :function
  belongs_to :permission
end
