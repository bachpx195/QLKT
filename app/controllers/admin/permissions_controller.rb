class Admin::PermissionsController < Admin::BaseController
  before_action :set_admin_permission, only: [:show, :edit, :update, :destroy]

  # GET /admin/permissions
  # GET /admin/permissions.json
  def index
    @admin_permissions = Admin::Permission.all
  end

  def search
    #TODO: Search
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  # GET /admin/permissions/1
  # GET /admin/permissions/1.json
  def show
  end

  # GET /admin/permissions/new
  def new
    @admin_permission = Admin::Permission.new
  end

  # GET /admin/permissions/1/edit
  def edit
  end

  # POST /admin/permissions
  # POST /admin/permissions.json
  def create
    @admin_permission = Admin::Permission.new(admin_permission_params)

    respond_to do |format|
      if @admin_permission.save
        format.html { redirect_to @admin_permission, notice: 'Permission was successfully created.' }
        format.json { render :show, status: :created, location: @admin_permission }
      else
        format.html { render :new }
        format.json { render json: @admin_permission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/permissions/1
  # PATCH/PUT /admin/permissions/1.json
  def update
    respond_to do |format|
      if @admin_permission.update(admin_permission_params)
        format.html { redirect_to @admin_permission, notice: 'Permission was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_permission }
      else
        format.html { render :edit }
        format.json { render json: @admin_permission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/permissions/1
  # DELETE /admin/permissions/1.json
  def destroy
    @admin_permission.destroy
    respond_to do |format|
      format.html { redirect_to admin_permissions_url, notice: 'Permission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_permission
      @admin_permission = Admin::Permission.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_permission_params
      params.require(:admin_permission).permit(:name, :value, :description)
    end
end
