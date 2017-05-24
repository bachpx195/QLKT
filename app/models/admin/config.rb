class Admin::Config < ApplicationRecord
  belongs_to :user
  belongs_to :config_category

  def self.search(search)
    search ? where("code LIKE ?", "%#{search[:code]}%") : all
  end
  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |config|
        csv << config.attributes.values_at(*column_names)
      end
    end
  end

  validates :code, length: { maximum: 255 }
  validates :value, length: { maximum: 255 }
  validates :description, length: { maximum: 500 }

end
