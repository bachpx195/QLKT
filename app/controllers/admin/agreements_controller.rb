class Admin::AgreementsController < Admin::BaseController
  include RenterAgreement
  before_action :set_admin_agreement, only: [:show, :edit, :update, :destroy, :duplicate, :agreement_form_edit,:agreement_form_destroy]
  # GET /admin/agreements
  # GET /admin/agreements.json
  def index
    if params.include?(:search)
      @admin_agreement_code = Admin::Agreement.where(user: current_user).search_by_code(params[:search])
      @admin_agreement_room = Admin::Agreement.where(user: current_user).search_by_room1(params[:search])
      @admin_agreement_building =  Admin::Agreement.where(user: current_user).search_by_room(Admin::Room.find_by_building(params[:search][:building]))
      @admin_agreement_status = Admin::Agreement.where(user: current_user).search_by_status(params[:search])
      @agreements = (@admin_agreement_code).merge(@admin_agreement_room).merge(@admin_agreement_building).merge(@admin_agreement_status)
      @admin_agreements = @agreements.order(updated_at: :desc).paginate(:page => params[:page])
    else
      @admin_agreements = Admin::Agreement.where(user: current_user).order(updated_at: :desc).paginate(:page => params[:page])
    end
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  def search
    @admin_buildings = Admin::Building.where(user: current_user)
    @admin_rooms = Admin::Room.where(user: current_user)

    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  # GET /admin/agreements/1
  # GET /admin/agreements/1.json
  def show
  end

  # GET /admin/agreements/new
  def new

    # GET BUILDING BY CURRENT USER
    @admin_buildings = Admin::Building.where(user: current_user)
    @admin_buildings = Admin::Building.where(user: current_user).where(parent_id: nil).order(parent_id: :asc)
    @admin_rooms = Admin::Room.where(user: current_user).where(building_id: 0)
    @admin_renters = Admin::Renter.where(user: current_user).where.not(id: Admin::AgreementRenter.where(user: current_user).pluck(:renter_id)).order(updated_at: :desc).all

    @admin_agreement = Admin::Agreement.new
    @admin_agreement.status = Admin::Constants::AGREEMENT_STATUS_VALID
    # Trường thông tin người đại diện, sẽ được lấy theo thông tin hợp đồng
    @admin_renters_in_agreement = @admin_agreement.renter.order(updated_at: :desc).all

    @admin_services = Admin::Service.where(user: current_user).find_by_building(0).order(updated_at: :desc).all
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  def agreements_by_room
    @admin_agreements = Admin::Agreement.where(user: current_user, room_id: params[:room_id], status: 1).order(updated_at: :desc).paginate(:page => params[:page])
    @agreement_room = Admin::Room.find(params[:room_id])
    @admin_building = @agreement_room.building
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  def agreement_form_destroy
    @agreement_destroy_id = @admin_agreement.id
    @admin_agreement.destroy
    @admin_agreement.status = 0
    @admin_agreement.save
    respond_to do |format|
      format.js { render :layout => false }
    end
  end

  def agreement_form_new
    # GET BUILDING BY CURRENT USER
    @admin_buildings = Admin::Building.where(id: params[:building_id]).take
    @admin_rooms = Admin::Room.where(user: current_user, id: params[:room_id])
    @admin_renters = Admin::Renter.where(user: current_user).where.not(id: Admin::AgreementRenter.where(user: current_user).pluck(:renter_id)).order(updated_at: :desc).all

    @admin_agreement = Admin::Agreement.new
    @admin_agreement.status = Admin::Constants::AGREEMENT_STATUS_VALID
    # Trường thông tin người đại diện, sẽ được lấy theo thông tin hợp đồng
    @admin_renters_in_agreement = @admin_agreement.renter.order(updated_at: :desc).all

    @admin_services = Admin::Service.where(user: current_user).find_by_building(0).order(updated_at: :desc).all
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  # GET /admin/agreements/1/edit
  def edit
    @admin_buildings = Admin::Building.where(user: current_user)

    @admin_rooms = Admin::Room.where(user: current_user).where(building_id: @admin_agreement.room.building_id, status: Admin::Constants::ROOM_EMPTY).or(Admin::Room.where(user: current_user).where(id: @admin_agreement.room.id))

    @admin_renters = Admin::Renter.where(user: current_user).where.not(id: Admin::AgreementRenter.where(user: current_user).pluck(:renter_id)).order(updated_at: :desc).all
    # Trường thông tin người đại diện, và danh sách sẵn có, sẽ được lấy theo thông tin hợp đồng
    @admin_renters_in_agreement = @admin_agreement.renter.order(updated_at: :desc).all
    @admin_services_in_agreement = @admin_agreement.agreement_service

    @admin_services = Admin::Service.where(user: current_user).find_by_building(@admin_agreement.room.building_id).where.not(id: @admin_services_in_agreement.pluck(:service_id)).order(updated_at: :desc).all
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  def agreement_form_edit
    @admin_buildings = Admin::Building.where(user: current_user)
    @admin_agreement = Admin::Agreement.find(params[:id])
    @admin_rooms = Admin::Room.where(id: @admin_agreement.room)
    @admin_renters = Admin::Renter.where(user: current_user).where.not(id: Admin::AgreementRenter.where(user: current_user).pluck(:renter_id)).order(updated_at: :desc).all
    # Trường thông tin người đại diện, và danh sách sẵn có, sẽ được lấy theo thông tin hợp đồng
    @admin_renters_in_agreement = @admin_agreement.renter.order(updated_at: :desc).all
    @admin_services_in_agreement = @admin_agreement.agreement_service

    @admin_services = Admin::Service.where(user: current_user).find_by_building(@admin_agreement.room.building_id).where.not(id: @admin_services_in_agreement.pluck(:service_id)).order(updated_at: :desc).all
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  # POST /admin/agreements
  # POST /admin/agreements.json
  def create
    @type = params[:actionType]

    @admin_agreement = Admin::Agreement.new(admin_agreement_params)
    @admin_agreement.user = current_user
    @admin_agreement.pre_payment = @admin_agreement.month_pre_payment * @admin_agreement.room.cost

    respond_to do |format|
      if @admin_agreement.save
        #Cập nhật lại trạng thái phòng, nếu là phòng đơn, phòng kém thì chỉ cập nhật khi sức chứa = số hợp đồng trong phòng đang còn hiệu lực.
        if @admin_agreement.room.room_type == Admin::Constants::RoomType::MULTY
          num_agreements = Admin::Agreement.where(user: current_user, room: @admin_agreement.room, status: Admin::Constants::AGREEMENT_STATUS_VALID).count
          if @admin_agreement.room.amount <= num_agreements
            admin_room = Admin::Room.find(@admin_agreement.room.id)
            admin_room.status = Admin::Constants::ROOM_RENTED
            admin_room.save!
          end
        else
          admin_room = Admin::Room.find(@admin_agreement.room.id)
          admin_room.status = Admin::Constants::ROOM_RENTED
          admin_room.save!
        end

        create_renters_agreement(current_user, @admin_agreement, params[:admin_agreement_renter])
        create_services_agreement(current_user, @admin_agreement, params[:admin_agreement_service], params[:admin_agreement_service_amount], params[:admin_agreement_service_status])
        @admin_agreements = Admin::Agreement.where(user: current_user).order(updated_at: :desc)
        format.html { redirect_to @admin_agreement, notice: t(:agreement_created) }
        format.json { render :show, status: :created, location: @admin_agreement }
        format.js { render :layout => false }
      else
        format.html { render :new }
        format.json { render json: @admin_agreement.errors, status: :unprocessable_entity }
        format.js { render :layout => false }
      end
    end
  end

  # PATCH/PUT /admin/agreements/1
  # PATCH/PUT /admin/agreements/1.json
  def update
    @type = params[:actionType]

    respond_to do |format|
      @admin_agreement.user = current_user
      if @admin_agreement.update(admin_agreement_params)

        create_renters_agreement(current_user, @admin_agreement, params[:admin_agreement_renter])
        create_services_agreement(current_user, @admin_agreement, params[:admin_agreement_service], params[:admin_agreement_service_amount], params[:admin_agreement_service_status])
        @admin_agreements = Admin::Agreement.where(user: current_user).order(updated_at: :desc).paginate(:page => params[:page])
        format.html { redirect_to @admin_agreement, notice: t(:agreement_updated) }
        format.json { render :show, status: :ok, location: @admin_agreement }
        format.js { render :layout => false }
      else
        format.html { render :edit }
        format.json { render json: @admin_agreement.errors, status: :unprocessable_entity }
        format.js { render :layout => false }
      end
    end
  end

  # DELETE /admin/agreements/1
  # DELETE /admin/agreements/1.json
  def destroy
    @admin_agreement.destroy
    respond_to do |format|
      format.html { redirect_to admin_agreements_url, notice: t(:agreement_destroyed) }
      format.json { head :no_content }
    end
  end

  def duplicate

    @admin_buildings = Admin::Building.where(user: current_user)
    @admin_rooms = Admin::Room.where(user: current_user).where(building_id: @admin_agreement.room.building_id)
    @admin_renters = Admin::Renter.where(user: current_user).where.not(id: Admin::AgreementRenter.where(user: current_user).pluck(:renter_id)).order(updated_at: :desc).all
    # Trường thông tin người đại diện, và danh sách sẵn có, sẽ được lấy theo thông tin hợp đồng
    @admin_renters_in_agreement = @admin_agreement.renter.order(updated_at: :desc).all
    @admin_services_in_agreement = @admin_agreement.agreement_service

    @admin_services = Admin::Service.where(user: current_user).find_by_building(@admin_agreement.room.building_id).where.not(id: @admin_services_in_agreement.pluck(:service_id)).order(updated_at: :desc).all

    @admin_agreement = Admin::Agreement.new(@admin_agreement.attributes)
    respond_to do |format|
      format.html { redirect_to @admin_agreement, notice: t(:agreement_created) }
      format.json
      format.js { render :layout => false }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_agreement
      @admin_agreement = Admin::Agreement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_agreement_params
      params[:admin_agreement][:duration] = params[:admin_agreement][:duration].gsub(".", "")
      params[:admin_agreement][:down_payment] = params[:admin_agreement][:down_payment].gsub(".", "")
      params[:admin_agreement][:billing_cycle] = params[:admin_agreement][:billing_cycle].gsub(".", "")

      params.require(:admin_agreement).permit(:room_id, :renter_id, :code, :duration, :start_date, :end_date, :out_date, :down_payment, :month_pre_payment, :billing_cycle, :status, :admin_agreement_renter)
    end

    def current_screen
      @current_screen = Admin::ScreenName::Agreement
    end

end
