class Admin::DashboardController < Admin::BaseController
  def index
    @admin_buildings = Admin::Building.all.where(user: current_user)
    @admin_agreements = Admin::Agreement.all.where(user: current_user, status: 1)
  end

  def electricity_water
    @room = Admin::Room.find(params[:id])
    @building = @room.building
    @month_year = Time.now
    @dashboard_admin_electricity_water = Admin::ElectricityWater.find_by(room_id: params[:id], year: @month_year.year, month: @month_year.month)
    respond_to do |format|
      format.js { render :layout => false }
    end
  end

  def update
    respond_to do |format|
      if @dashboard_admin_electricity_water.update(dashboard_admin_electricity_water_params)
        format.html { redirect_to @dashboard_admin_electricity_water }
        format.json { render :show, status: :ok, location: @dashboard_admin_electricity_water }
        format.js { render :layout => false }
      else
        format.html { render :update }
        format.json { render json: @dashboard_admin_electricity_water.errors, status: :unprocessable_entity }
        format.js { render :layout => false }
      end
    end
  end

  private
  def current_screen
    @current_screen = Admin::ScreenName::Dashboard
  end

    def dashboard_admin_electricity_water_params
      params.require(:admin_electricity_water)[:month] = params[:month_year].month
      params.require(:admin_electricity_water)[:year] = params[:month_year].year
      params.require(:admin_electricity_water).permit(:user_id, :room_id, :year, :month, :start_electricity, :end_electricity, :total_electricity, :start_water, :end_water, :total_water)
    end
end
