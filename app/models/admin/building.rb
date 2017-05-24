class Admin::Building < ApplicationRecord
  belongs_to :user
  has_many :rooms
  has_many :services

  belongs_to :parent, class_name: 'Admin::Building', optional: true
  has_many :children, class_name: 'Admin::Building', foreign_key: :parent_id

  delegate :name, :to => :parent, :prefix => true, :allow_nil => true

  validates :name, presence: true, length: { maximum: 255 }

  def self.search(search)
    search ? where("name LIKE ?", "%#{search[:name]}%") : all
  end

  def self.search_by_id(search)
    if !search.nil?
      where(:id => "#{search[:building]}")
    else
      all
    end

  end
end
