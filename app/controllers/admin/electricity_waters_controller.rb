class Admin::ElectricityWatersController < Admin::BaseController
  include Commons
  before_action :set_admin_electricity_water, only: [:show, :edit, :update, :destroy, :duplicate]
  before_action :set_admin_buildings, only:  [:new, :edit, :edit_by_conditions]

  # GET /admin/electricity_waters
  # GET /admin/electricity_waters.json
  def index
    # PARAMS
    @month_year = "#{Time.now.month}/#{Time.now.year}"
    if (!params[:search].nil? && !params[:search][:month_year].nil?)
      @month_year = params[:search][:month_year]
    end

    @building = "0"
    if (!params[:search].nil? && !params[:search][:building].nil?)
      @building = params[:search][:building]
    end

    @room = "0"
    if (!params[:search].nil? && !params[:search][:room].nil?)
      @room = params[:search][:room]
    end

    @admin_buildings = buildings(current_user)
    @admin_rooms = Admin::Room.where(user: current_user).where(building_id: @building)

    @date = DateTime.strptime(@month_year, '%m/%Y')

    @admin_electricity_waters = Admin::Room.select_electricity_waters(@building, @room, (@date - 1.month).month, (@date - 1.month).year, @date.month, @date.year, current_user.id).paginate(:page => params[:page])

    @export = Admin::ElectricityWater.where(user: current_user)

    respond_to do |format|
      format.html
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="Configs.xlsx"'
      }
      format.js { render :layout => false }
    end
  end

  def search
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  # GET /admin/electricity_waters/1
  # GET /admin/electricity_waters/1.json
  def show
  end

  # GET /admin/electricity_waters/new
  def new
    @admin_rooms = Admin::Room.where(user: current_user).where(id: 0)
    @admin_electricity_water = Admin::ElectricityWater.new
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  # GET /admin/electricity_waters/1/edit
  def edit
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  def edit_by_conditions
    if (!params[:room_id].nil? && !params[:year].nil? && !params[:month].nil?)
      room = Admin::Room.find(params[:room_id])
      if (!room.nil?)
        @admin_rooms = Admin::Room.where(user: current_user).where(building_id: room.building.id)
        @admin_electricity_water = Admin::ElectricityWater.find_by(room_id: params[:room_id], year: params[:year], month: params[:month])
        if (@admin_electricity_water.nil?)
          @admin_electricity_water = Admin::ElectricityWater.new
          @admin_electricity_water.room = room
          @admin_electricity_water.year = params[:year]
          @admin_electricity_water.month = params[:month]
          @admin_electricity_water.start_electricity = params[:start_electricity]
          @admin_electricity_water.start_water = params[:start_water]
          @admin_electricity_water.end_electricity = 0
          @admin_electricity_water.total_electricity = 0
          @admin_electricity_water.end_water = 0
          @admin_electricity_water.total_water = 0
        end
      end
    end
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end


  # POST /admin/electricity_waters
  # POST /admin/electricity_waters.json
  def create
    @admin_electricity_water = Admin::ElectricityWater.new(admin_electricity_water_params)
    @admin_electricity_water.user = current_user
    respond_to do |format|
      if @admin_electricity_water.save
        format.html { redirect_to @admin_electricity_water, notice: t(:created) }
        format.json { render :show, status: :created, location: @admin_electricity_water }
        format.js { render :layout => false }
      else
        format.html { render :new }
        format.json { render json: @admin_electricity_water.errors, status: :unprocessable_entity }
        format.js { render :layout => false }
      end
    end
  end

  # PATCH/PUT /admin/electricity_waters/1
  # PATCH/PUT /admin/electricity_waters/1.json
  def update
    respond_to do |format|
      if @admin_electricity_water.update(admin_electricity_water_params)
        format.html { redirect_to @admin_electricity_water, notice: t(:updated) }
        format.json { render :show, status: :ok, location: @admin_electricity_water }
        format.js { render :layout => false }
      else
        format.html { render :edit }
        format.json { render json: @admin_electricity_water.errors, status: :unprocessable_entity }
        format.js { render :layout => false }
      end
    end
  end

  # DELETE /admin/electricity_waters/1
  # DELETE /admin/electricity_waters/1.json
  def destroy
    @admin_electricity_water.destroy
    respond_to do |format|
      format.html { redirect_to admin_electricity_waters_url, notice: t(:deleted) }
      format.json { head :no_content }
    end
  end

  def duplicate
    @admin_electricity_water = Admin::ElectricityWater.new(@admin_electricity_water.attributes)
    respond_to do |format|
      format.html { redirect_to admin_electricity_waters_url, notice: t(:config_notice_created) }
      format.json
      format.js { render :layout => false }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_electricity_water
      @admin_electricity_water = Admin::ElectricityWater.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_electricity_water_params
      strMonthYear = params[:admin_electricity_water][:month_year]
      params.require(:admin_electricity_water)[:month] = strMonthYear.split('/').first
      params.require(:admin_electricity_water)[:year] = strMonthYear.split('/').last
      params.require(:admin_electricity_water).permit(:user_id, :room_id, :year, :month, :start_electricity, :end_electricity, :total_electricity, :start_water, :end_water, :total_water)
    end

    def set_admin_buildings
      @admin_buildings = buildings(current_user)
    end

    def current_screen
      @current_screen = Admin::ScreenName::ElectricityWater
    end
end
