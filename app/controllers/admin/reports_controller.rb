class Admin::ReportsController < Admin::BaseController
  include Commons

  def index
    @month_year_from = "#{Time.now.month}/#{Time.now.year}"
    if (!params[:search].nil? && !params[:search][:month_year_from].nil?)
      @month_year_from = params[:search][:month_year_from]
    end

    @month_year_end = "#{Time.now.month}/#{Time.now.year}"
    if (!params[:search].nil? && !params[:search][:month_year_end].nil?)
      @month_year_end = params[:search][:month_year_end]
    end

    @building = 0
    if (!params[:search].nil? && !params[:search][:building].nil?)
      @building = params[:search][:building]
    end
    if params.include?(:search)
    @admin_buildings = Admin::Building.where(user: current_user).search_by_id(params[:search])
    @admin_rooms = Admin::Room.where(user: current_user).search_by_building(params[:search])
    @admin_buildings = buildings(current_user)
    else
      @admin_buildings = Admin::Building.where(user: current_user)
      @admin_rooms = Admin::Room.where(user: current_user)

      @admin_buildings = buildings(current_user)

    end

    @admin_agreements = Admin::Agreement.where(user: current_user).search_by_room(@admin_rooms)

    @admin_bills_building = Admin::Bill.where(user: current_user).search_by_agreements(@admin_agreements)

    @admin_bills_time= Admin::Bill.where(user: current_user).search_by_time(params[:search])
    if @admin_bills_building != nil && @admin_bills_time != nil
      @admin_bills_total = (@admin_bills_building).merge(@admin_bills_time)
    elsif @admin_bills_building != nil
      @bills_total = @admin_bills_time
    else
      @bills_total = @admin_bills_building
    end

    @total_revenue=  Admin::Bill.sum_payment_amount(@admin_bills_total)
  end


  def edit
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  def detail
    @admin_building = Admin::Building.find(params[:id])
    @admin_rooms = Admin::Room.where(building: @admin_building)
    @admin_report = Admin::Report.first
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end
  def show

  end

  private

  def current_screen
    @current_screen = Admin::ScreenName::Report
  end
end

