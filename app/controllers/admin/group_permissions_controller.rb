class Admin::GroupPermissionsController < Admin::BaseController
  before_action :set_admin_group_permission, only: [:show, :edit, :update, :destroy]

  # GET /admin/group_permissions
  # GET /admin/group_permissions.json
  def index
    @admin_group_permissions = Admin::GroupPermission.all
  end

  def search
    #TODO: Search
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  # GET /admin/group_permissions/1
  # GET /admin/group_permissions/1.json
  def show
  end

  # GET /admin/group_permissions/new
  def new
    @admin_group_permission = Admin::GroupPermission.new
  end

  # GET /admin/group_permissions/1/edit
  def edit
  end

  # POST /admin/group_permissions
  # POST /admin/group_permissions.json
  def create
    @admin_group_permission = Admin::GroupPermission.new(admin_group_permission_params)

    respond_to do |format|
      if @admin_group_permission.save
        format.html { redirect_to @admin_group_permission, notice: 'Group permission was successfully created.' }
        format.json { render :show, status: :created, location: @admin_group_permission }
      else
        format.html { render :new }
        format.json { render json: @admin_group_permission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/group_permissions/1
  # PATCH/PUT /admin/group_permissions/1.json
  def update
    respond_to do |format|
      if @admin_group_permission.update(admin_group_permission_params)
        format.html { redirect_to @admin_group_permission, notice: 'Group permission was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_group_permission }
      else
        format.html { render :edit }
        format.json { render json: @admin_group_permission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/group_permissions/1
  # DELETE /admin/group_permissions/1.json
  def destroy
    @admin_group_permission.destroy
    respond_to do |format|
      format.html { redirect_to admin_group_permissions_url, notice: 'Group permission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_group_permission
      @admin_group_permission = Admin::GroupPermission.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_group_permission_params
      params.require(:admin_group_permission).permit(:group_id, :function_id, :permission_id)
    end
end
