class Admin::RoomsController < Admin::BaseController
  include Commons
  before_action :set_admin_room, only: [:show, :edit, :update, :destroy, :duplicate, :devices]
  before_action :set_admin_buildings, only: [:new, :edit, :duplicate]
  # GET /admin/rooms
  # GET /admin/rooms.json
  def index
    if !params[:room_id].nil?
      @admin_rooms = Admin::Room.where(id: params[:room_id])
    else
      if params[:building_id].nil?
        @admin_rooms = Admin::Room.where(user: current_user).paginate(:page => params[:page])
      else
        if params[:is_agreement].nil?
          @admin_rooms = Admin::Room.where(user: current_user).find_by_building(params[:building_id]).paginate(:page => params[:page])
        else
          if params[:last_room].nil?
            @admin_rooms = Admin::Room.where(user: current_user).find_by_building(params[:building_id], params[:is_agreement]).paginate(:page => params[:page])
          else
            @admin_rooms = Admin::Room.where(user: current_user).find_by_building(params[:building_id], params[:is_agreement], params[:last_room]).paginate(:page => params[:page])
          end
        end
      end
    end

    @admin_buildings = buildings(current_user)
    @export = Admin::Room.where(user: current_user)
    respond_to do |format|
      format.html
      format.json
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="Phong.xlsx"'
      }
      format.js { render :layout => false }
    end
  end

  def search
    @building = "0"
    if (!params[:search].nil? && !params[:search][:building].nil?)
      @building = params[:search][:building]
    end
    @name = ""
    if (!params[:search].nil? && !params[:search][:name].nil?)
      @name = params[:search][:name]
    end
    @type = ""
    if (!params[:search].nil? && !params[:search][:type].nil?)
      @type = params[:search][:type]
    end
    @status = ""
    if (!params[:search].nil? && !params[:search][:status].nil?)
      @status = params[:search][:status]
    end
    @admin_rooms = Admin::Room.search_room(current_user.id, @name, @type, @status).paginate(:page => params[:page])

    @admin_buildings = buildings(current_user)
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  def devices
    respond_to do |format|
      format.js { render :layout => false }
    end
  end

  # GET /admin/rooms/1
  # GET /admin/rooms/1.json
  def show
  end

  # GET /admin/rooms/new
  def new
    @admin_room = Admin::Room.new
    @admin_room.building_id = params[:building]
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  # GET /admin/rooms/1/edit
  def edit
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  # POST /admin/rooms
  # POST /admin/rooms.json
  def create
    @admin_room = Admin::Room.new(admin_room_params)
    @admin_room.user = current_user
    @admin_room.status = Admin::Constants::ROOM_EMPTY
    respond_to do |format|
      if @admin_room.save
        @admin_buildings = buildings(current_user)
        @admin_rooms = Admin::Room.where(user: current_user).paginate(:page => params[:page])

        format.html { redirect_to @admin_room, notice: t(:created) }
        format.json { render :show, status: :created, location: @admin_room }
        format.js { render :layout => false }
      else
        format.html { render :new }
        format.json { render json: @admin_room.errors, status: :unprocessable_entity }
        format.js { render :layout => false }
      end
    end
  end

  # PATCH/PUT /admin/rooms/1
  # PATCH/PUT /admin/rooms/1.json
  def update
    respond_to do |format|
      if @admin_room.update(admin_room_params)
        @admin_buildings = buildings(current_user)
        @admin_rooms = Admin::Room.where(user: current_user).paginate(:page => params[:page])

        format.html { redirect_to @admin_room, notice: t(:updated) }
        format.json { render :show, status: :ok, location: @admin_room }
        format.js { render :layout => false }
      else
        format.html { render :edit }
        format.json { render json: @admin_room.errors, status: :unprocessable_entity }
        format.js { render :layout => false }
      end
    end
  end

  # DELETE /admin/rooms/1
  # DELETE /admin/rooms/1.json
  def destroy
    agreement_rooms = Admin::Agreement.where(user: current_user, room_id: @admin_room.id).count
    device_rooms = Admin::RoomDevice.where(user: current_user, room_id: @admin_room.id).count
    electricity_water_rooms = Admin::ElectricityWater.where(user: current_user, room_id: @admin_room.id).count

    @message = t(:deleted)
    is_error = false
    if agreement_rooms == 0 && device_rooms == 0 && electricity_water_rooms == 0
      if !@admin_room.destroy
        @message = t(:error)
        is_error = true
      end
    else
      @message = t(:room_error_destroyed)
      is_error = true
    end

    respond_to do |format|
      if is_error
        format.html { redirect_to admin_rooms_url, alert: @message }
      else
        format.html { redirect_to admin_rooms_url, notice: @message }
      end
    end
  end

  def duplicate
    @admin_room = Admin::Room.new(@admin_room.attributes)
    render :new
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_room
      @admin_room = Admin::Room.find(params[:id])
    end

    def set_admin_buildings
      @admin_buildings = buildings(current_user)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_room_params
      params[:admin_room][:amount] = params[:admin_room][:amount].gsub(".", "")
      params[:admin_room][:cost] = params[:admin_room][:cost].gsub(".", "")
      params.require(:admin_room).permit(:user_id, :building_id, :code, :name, :room_type, :amount, :cost, :status, :description)
    end

    def current_screen
      @current_screen = Admin::ScreenName::Room
    end
end