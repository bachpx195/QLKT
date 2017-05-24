module Admin::DashboardHelper
  def total_renter(room_id)
    Admin::Agreement.where(:room_id => room_id).where('start_date < ?', Date.today).count(:renter_id)
  end


end