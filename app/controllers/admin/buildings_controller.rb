class Admin::BuildingsController < Admin::BaseController
  include Commons
  before_action :set_admin_building, only: [:show, :edit, :update, :destroy, :duplicate]
  before_action :set_admin_buildings, only: [:new, :edit, :duplicate]

  # GET /admin/buildings
  # GET /admin/buildings.json
  def index
    @admin_buildings = Admin::Building.search(params[:search]).where(user: current_user).where(parent_id: nil).order(parent_id: :asc)

    @admin_buildings = buildings(current_user)

    @export = Admin::Building.where(user: current_user).order(parent_id: :asc)
    respond_to do |format|
      format.html
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="Buildings.xlsx"'
      }
      format.js { render :layout => false }
    end
  end

  def search
    #TODO: Search
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  # GET /admin/buildings/1
  # GET /admin/buildings/1.json
  def show
  end

  # GET /admin/buildings/new
  def new
    @admin_building = Admin::Building.new
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  # GET /admin/buildings/1/edit
  def edit
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  # POST /admin/buildings
  # POST /admin/buildings.json
  def create
    @admin_building = Admin::Building.new(admin_building_params)
    @admin_building.user = current_user
    respond_to do |format|
      if @admin_building.save

        @admin_buildings = buildings(current_user)

        create_default_service(@admin_building)

        format.html { redirect_to @admin_building, notice: t(:building_notice_created) }
        format.json { render :show, status: :created, location: @admin_building }
        format.js { render :layout => false }
      else
        format.html { render :new }
        format.json { render json: @admin_building.errors, status: :unprocessable_entity }
        format.js { render :layout => false }
      end
    end
  end

  # PATCH/PUT /admin/buildings/1
  # PATCH/PUT /admin/buildings/1.json
  def update
    respond_to do |format|
      if @admin_building.update(admin_building_params)
        @admin_buildings = buildings(current_user)

        format.html { redirect_to @admin_building, notice: t(:building_notice_updated) }
        format.json { render :show, status: :ok, location: @admin_building }
        format.js { render :layout => false }
      else
        format.html { render :edit }
        format.json { render json: @admin_building.errors, status: :unprocessable_entity }
        format.js { render :layout => false }
      end
    end
  end

  # DELETE /admin/buildings/1
  # DELETE /admin/buildings/1.json
  def destroy
    @admin_building.destroy
    respond_to do |format|
      format.html { redirect_to admin_buildings_url, notice: t(:building_notice_destroyed) }
      format.json { head :no_content }
    end
  end

  def duplicate
    @admin_building = Admin::Building.new(@admin_building.attributes)
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_admin_building
    @admin_building = Admin::Building.find(params[:id])
  end

  def set_admin_buildings
    @admin_buildings = buildings(current_user)
  end

  def create_default_service(building)
    # ROOM
    service = Admin::Service.new
    service.user = current_user
    service.building = building
    service.name = Admin::Constants::SERVICES::NAME_ROOM
    service.unit = Admin::Constants::SERVICES::UNIT_ROOM
    service.description = Admin::Constants::SERVICES::NAME_ROOM
    service.code = Admin::Constants::SERVICES::CODE_ROOM
    service.service_type = Admin::Constants::SERVICES::TYPE_FIX
    service.save!
    # ELECTRICTITY
    service = Admin::Service.new
    service.user = current_user
    service.building = building
    service.name = Admin::Constants::SERVICES::NAME_ELECTRICITY
    service.unit = Admin::Constants::SERVICES::UNIT_ELECTRICITY
    service.unit_price = Admin::Constants::SERVICES::UNIT_PRICE_ELECTRICITY
    service.description = Admin::Constants::SERVICES::NAME_ELECTRICITY
    service.code = Admin::Constants::SERVICES::CODE_ELECTRICITY
    service.service_type = Admin::Constants::SERVICES::TYPE_FIX
    service.save!
    # WATER
    service = Admin::Service.new
    service.user = current_user
    service.building = building
    service.name = Admin::Constants::SERVICES::NAME_WATER
    service.unit = Admin::Constants::SERVICES::UNIT_WATER
    service.unit_price = Admin::Constants::SERVICES::UNIT_PRICE_WATER
    service.description = Admin::Constants::SERVICES::NAME_WATER
    service.code = Admin::Constants::SERVICES::CODE_WATER
    service.service_type = Admin::Constants::SERVICES::TYPE_FIX
    service.save!
    # WATER PER PERSON
    service = Admin::Service.new
    service.user = current_user
    service.building = building
    service.name = Admin::Constants::SERVICES::NAME_WATER
    service.unit = Admin::Constants::SERVICES::UNIT_WATER_PER_PERSON
    service.unit_price = Admin::Constants::SERVICES::UNIT_PRICE_WATER_PER_PERSON
    service.description = Admin::Constants::SERVICES::NAME_WATER
    service.code = Admin::Constants::SERVICES::CODE_WATER_PER_PERSON
    service.service_type = Admin::Constants::SERVICES::TYPE_FIX
    service.save!
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_building_params
    params.require(:admin_building).permit(:user_id, :parent_id, :code, :name, :description)
  end

  def current_screen
    @current_screen = Admin::ScreenName::Building
  end
end
