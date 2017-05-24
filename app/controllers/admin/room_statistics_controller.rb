class Admin::RoomStatisticsController < Admin::BaseController
  #before_action :set_admin_room_statistic, only: [:show]

  # GET /admin/room_statistics
  # GET /admin/room_statistics.json
  helper_method :sort_direction, :sort_column

  def index
    @admin_room_statistics = Admin::RoomStatistic.where(user: current_user).order(sort_column + " "+ sort_direction).paginate(:page => params[:page])
    filtering_params(params).each do |key, value|
      @admin_room_statistics = @admin_room_statistics.public_send(key, value) if value.present?
    end
    # @admin_room_statistics = Admin::RoomStatistic.paginate(:page => params[:page])
    @export = Admin::RoomStatistic.where(user: current_user).order(updated_at: :desc)
    respond_to do |format|
      format.html
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="RoomStatistic.xlsx"'
      }
      format.js { render :layout => false }
    end
  end

  # GET /admin/room_statistics/1
  # GET /admin/room_statistics/1.json
  def show
  end

  def search_form
   @admin_buildings = Admin::Building.all
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  def search
    #TODO: Search
    @admin_room_statistics = Admin::RoomStatistic.where(user: current_user).prepair_condition(params[:range]).order(sort_column + " "+ sort_direction).paginate(:page => params[:page])
    filtering_params(params).each do |key, value|
      @admin_room_statistics = @admin_room_statistics.public_send(key, value) if value.present?
    end
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def filtering_params(params)
    params.slice(:status, :building, :room_type)
  end

  def sort_column
    Admin::RoomStatistic.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def set_admin_room_statistic
    @admin_room_statistic = Admin::Room.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_room_statistic_params
    params.fetch(:admin_room_statistic, {})
  end

  def current_screen
    @current_screen = Admin::ScreenName::RoomStatistic
  end
end
