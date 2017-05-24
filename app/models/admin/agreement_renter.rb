class Admin::AgreementRenter < ApplicationRecord
  belongs_to :user
  belongs_to :agreement
  belongs_to :renter

  scope :user_scope, lambda { |user|
    Admin::AgreementRenter.where(user_id: user.id)
  }
end
