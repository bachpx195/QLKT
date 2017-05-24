class Admin::GroupsController < Admin::BaseController
  before_action :set_admin_group, only: [:show, :edit, :update, :destroy]
  # GET /admin/groups
  # GET /admin/groups.json

  def index
    @admin_groups = Admin::Group.paginate(:page => params[:page])
  end

  def search
    #TODO: Search
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  # GET /admin/groups/1
  # GET /admin/groups/1.json
  def show
  end

  # GET /admin/groups/new
  def new
    @admin_group = Admin::Group.new
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  # GET /admin/groups/1/edit
  def edit
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  # POST /admin/groups
  # POST /admin/groups.json
  def create
    @admin_group = Admin::Group.new(admin_group_params)

    respond_to do |format|
      if @admin_group.save
        @admin_groups = Admin::Group.paginate(:page => params[:page])
        format.html { redirect_to @admin_group, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @admin_group }
        format.js { render :layout => false }
      else
        format.html { render :new }
        format.json { render json: @admin_group.errors, status: :unprocessable_entity }
        format.js { render :layout => false }
      end
    end
  end

  # PATCH/PUT /admin/groups/1
  # PATCH/PUT /admin/groups/1.json
  def update
    respond_to do |format|
      if @admin_group.update(admin_group_params)
        @admin_groups = Admin::Group.paginate(:page => params[:page])
        format.html { redirect_to @admin_group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_group }
        format.js { render :layout => false }
      else
        format.html { render :edit }
        format.json { render json: @admin_group.errors, status: :unprocessable_entity }
        format.js { render :layout => false }
      end
    end
  end

  # DELETE /admin/groups/1
  # DELETE /admin/groups/1.json
  def destroy
    @admin_group.destroy
    respond_to do |format|
      format.html { redirect_to admin_groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_group
      @admin_group = Admin::Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_group_params
      params.require(:admin_group).permit(:name, :level, :description)
    end

    def current_screen
      @current_screen = Admin::ScreenName::Group
    end
end
