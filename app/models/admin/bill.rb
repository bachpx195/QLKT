class Admin::Bill < ApplicationRecord
  belongs_to :user
  belongs_to :agreement
  belongs_to :room

  has_many :bill_detail, dependent: :destroy

  after_create :update_code

  def month_year
    "#{month}" + "/" + "#{year}"
  end

  def to_label
    "#{code}"
  end

  def self.search_by_agreements(admin_agreements)
    where(:agreement_id =>  admin_agreements.map(&:id))
  end

  def self.search_by_time(search)
    if search!=nil
      strMonthYearFrom= search[:month_year_from]
      monthFrom = strMonthYearFrom.split('/').first
      yearFrom = strMonthYearFrom.split('/').last
      strMonthYearEnd= search[:month_year_end]
      monthEnd = strMonthYearEnd.split('/').first
      yearEnd = strMonthYearEnd.split('/').last
      if yearFrom == yearEnd
        search ? where("month BETWEEN ? AND ? AND year = ?",  monthFrom, monthEnd, yearEnd) : all
        # else
        #   search ? where("month BETWEEN ? AND 12 AND year = ?",  monthFrom, yearEnd) : all
      end
    else
      all
    end
  end

  def self.sum_payment_amount(admin_bills)
    total_revenue= Array.new
    if admin_bills!=nil
    admin_bills.each do |bill|
      if bill[:payment_amount] != nil
        total_revenue.push( bill[:payment_amount])
        end
    end
    else
      total_revenue.push("0")
    end
    return total_revenue
  end

  def update_code
    self.update_column(:code, generate_code(Admin::Constants::AutoGenerateCode::BILL, self.id)) # This will skip validation gracefully.
  end

end
