class Admin::RoomDevicesController < Admin::BaseController
  include Commons
  before_action :set_admin_room_device, only: [:show, :edit, :room_form_edit, :update, :destroy, :duplicate, :room_form_destroy]

  # GET /admin/room_devices
  # GET /admin/room_devices.json
  def index
    @admin_room_devices = Admin::RoomDevice.search(params[:search]).where(user: current_user).paginate(:page => params[:page])
    @export = Admin::RoomDevice.all
    respond_to do |format|
      format.html
      format.json
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="Room_Devices.xlsx"'
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

  # GET /admin/room_devices/1
  # GET /admin/room_devices/1.json
  def show
  end

  # GET /admin/room_devices/new
  def new
    @admin_buildings = buildings(current_user)
    @admin_rooms = Admin::Room.where(user: current_user).where(building_id: 0)
    @admin_room_device = Admin::RoomDevice.new
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  def room_form_new
    @admin_buildings = buildings(current_user)
    @admin_rooms = Admin::Room.where(user: current_user).where(building_id: 0)
    @admin_room_device = Admin::RoomDevice.new
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  # GET /admin/room_devices/1/edit
  def edit
    @admin_buildings = buildings(current_user)
    @admin_rooms = Admin::Room.where(user: current_user).where(building_id: @admin_room_device.room.building_id, status: Admin::Constants::ROOM_EMPTY).or(Admin::Room.where(user: current_user).where(id: @admin_room_device.room.id))
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  def room_form_edit
    @types = params[:types]
    @admin_buildings = buildings(current_user)
    @admin_rooms = Admin::Room.where(user: current_user).where(building_id: @admin_room_device.room.building_id, status: Admin::Constants::ROOM_EMPTY).or(Admin::Room.where(user: current_user).where(id: @admin_room_device.room.id))
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  # POST /admin/room_devices
  # POST /admin/room_devices.json
  def create
    @type = params[:actionType]
    @admin_room_device = Admin::RoomDevice.new(admin_room_device_params)
    @admin_room_device.user = current_user
    respond_to do |format|
      if @admin_room_device.save
        @admin_room_devices = Admin::RoomDevice.where(user: current_user).paginate(:page => params[:page])
        format.html { redirect_to @admin_room_device, notice: 'Room device was successfully created.' }
        format.json { render :show, status: :created, location: @admin_room_device }
        format.js { render :layout => false }
      else
        format.html { render :new }
        format.json { render json: @admin_room_device.errors, status: :unprocessable_entity }
        format.js { render :layout => false }
      end
    end
  end

  # PATCH/PUT /admin/room_devices/1
  # PATCH/PUT /admin/room_devices/1.json
  def update
    @type = params[:actionType]

    respond_to do |format|
      if @admin_room_device.update(admin_room_device_params)
        @admin_room_devices = Admin::RoomDevice.where(user: current_user).paginate(:page => params[:page])
        format.html { redirect_to @admin_room_device, notice: 'Room device was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_room_device }
        format.js { render :layout => false }
      else
        format.html { render :edit }
        format.json { render json: @admin_room_device.errors, status: :unprocessable_entity }
        format.js { render :layout => false }
      end
    end
  end

  def duplicate
    @admin_buildings = Admin::Building.where(user: current_user)
    @admin_rooms = Admin::Room.where(user: current_user).where(building_id: @admin_room_device.room.building_id)
    @admin_room_device = Admin::RoomDevice.new(@admin_room_device.attributes)
    render :new
  end

  # DELETE /admin/room_devices/1
  # DELETE /admin/room_devices/1.json
  def destroy
    @admin_room_device.destroy
    respond_to do |format|
      format.html { redirect_to admin_room_devices_url, notice: 'Room device was successfully destroyed.' }
      format.json { head :no_content }
      format.js { render :layout => false }
    end
  end

  def room_form_destroy
    @room_device_destroy_id = @admin_room_device.id
    @admin_room_device.destroy
    respond_to do |format|
      format.js { render :layout => false }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_admin_room_device
    @admin_room_device = Admin::RoomDevice.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_room_device_params
    params.require(:admin_room_device).permit(:user_id, :room_id, :name, :amount, :status, :description)
  end

  def current_screen
    @current_screen = Admin::ScreenName::RoomDevice
  end
end
