class Admin::ServicesController < Admin::BaseController
  include Commons
  before_action :set_admin_service, only: [:show, :edit, :update, :destroy, :duplicate]
  before_action :set_admin_buildings, only: [:new, :edit, :duplicate]

  # GET /admin/services
  # GET /admin/services.json
  def index
    if params[:building_id].nil?
      @admin_services = Admin::Service.where(user: current_user).search(params[:search]).order(building_id: :asc, service_type: :desc).paginate(:page => params[:page])
    else
      @admin_services = Admin::Service.where(user: current_user).find_by_building(params[:building_id])
    end

    @admin_buildings = buildings(current_user)
    @export = Admin::Service.where(user: current_user).search(params[:search]).order(building_id: :asc, updated_at: :desc)

    respond_to do |format|
      format.html
      format.json
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="Services.xlsx"'
      }
      format.js { render :layout => false }
    end
  end

  # def set_current_user
  #   @admin_service.user = current_user
  # end

  def search_form
    @admin_buildings = Admin::Building.where(user: current_user)
    @admin_services = Admin::Service.all

    @admin_buildings = buildings(current_user)
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  def search
    #TODO: Search
    @admin_services = Admin::Service.where(user: current_user).search(params[:search]).paginate(:page => params[:page])

    @admin_buildings = buildings(current_user)
   # @admin_services_building = Admin::Service.where(user: current_user).find_by_building(params[:building_id]).paginate(:page => params[:page])
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  # GET /admin/services/1
  # GET /admin/services/1.json
  def show
  end

  # GET /admin/services/new
  def new
    @admin_service = Admin::Service.new
    @admin_service.building_id = params[:building]
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  # GET /admin/services/1/edit
  def edit
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  # POST /admin/services
  # POST /admin/services.json
  def create
    @admin_service = Admin::Service.new(admin_service_params)
    @admin_service.user = current_user
    respond_to do |format|
      if @admin_service.save
        @admin_services = Admin::Service.where(user: current_user).order(building_id: :asc, updated_at: :desc).paginate(:page => params[:page])
        @admin_buildings = buildings(current_user)

        format.html { redirect_to @admin_service, notice: t(:created) }
        format.json { render :show, status: :created, location: @admin_service }
        format.js { render :layout => false }
      else
        format.html { render :new }
        format.json { render json: @admin_service.errors, status: :unprocessable_entity }
        format.js { render :layout => false }
      end
    end
  end

  # PATCH/PUT /admin/services/1
  # PATCH/PUT /admin/services/1.json
  def update
    respond_to do |format|
      if @admin_service.update(admin_service_params)
        @admin_buildings = buildings(current_user)

        @admin_services = Admin::Service.where(user: current_user).order(building_id: :asc, updated_at: :desc).paginate(:page => params[:page])
        format.html { redirect_to @admin_service, notice: t(:updated) }
        format.json { render :show, status: :ok, location: @admin_service }
        format.js { render :layout => false }
      else
        format.html { render :edit }
        format.json { render json: @admin_service.errors, status: :unprocessable_entity }
        format.js { render :layout => false }
      end
    end
  end

  def duplicate
    @admin_service = Admin::Service.new(@admin_service.attributes)
    render :new
  end

  # DELETE /admin/services/1
  # DELETE /admin/services/1.json
  def destroy
    agreement_services = Admin::AgreementService.where(user: current_user, service_id: @admin_service.id).count
    bill_services = Admin::BillDetail.where(user: current_user, service_id: @admin_service.id).count

    @message = t(:deleted)
    is_error = false
    if agreement_services == 0 && bill_services == 0
      if !@admin_service.destroy
        @message = t(:error)
        is_error = true
      end
    else
      @message = t(:error_both)
      is_error = true
    end

    respond_to do |format|
      if is_error
        format.html { redirect_to admin_services_url, alert: @message }
      else
        format.html { redirect_to admin_services_url, notice: @message }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_admin_service
    @admin_service = Admin::Service.find(params[:id])
  end

  def set_admin_buildings
    @admin_buildings = Admin::Building.where(user: current_user)

    @admin_buildings = buildings(current_user)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_service_params
    params[:admin_service][:unit_price] = params[:admin_service][:unit_price].gsub(".", "")
    params.require(:admin_service).permit(:user_id, :building_id, :name, :unit, :unit_price, :description)
  end

  def current_screen
    @current_screen = Admin::ScreenName::Service
  end

end
