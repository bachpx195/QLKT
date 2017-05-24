class Admin::BillDetail < ApplicationRecord
  belongs_to :user
  belongs_to :bill
  belongs_to :service
end
