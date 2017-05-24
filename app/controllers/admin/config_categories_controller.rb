class Admin::ConfigCategoriesController < Admin::BaseController
  before_action :set_admin_config_category, only: [:show, :edit, :update, :destroy, :duplicate]

  # GET /admin/config_categories
  # GET /admin/config_categories.json
  def index
    @admin_config_categories = Admin::ConfigCategory.all.paginate(:page => params[:page])
    @export = Admin::ConfigCategory.all
    respond_to do |format|
      format.html
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="Config-category.xlsx"'
      }
      format.js { render :layout => false }
    end
  end

  # GET /admin/config_categories/1
  # GET /admin/config_categories/1.json
  def show
  end

  def search
    #TODO: Search
    @admin_config_categories = Admin::ConfigCategory.search(params[:search]).paginate(:page => params[:page])
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  # GET /admin/config_categories/new
  def new
    @admin_config_category = Admin::ConfigCategory.new
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  # GET /admin/config_categories/1/edit
  def edit
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  # POST /admin/config_categories
  # POST /admin/config_categories.json
  def create
    @admin_config_category = Admin::ConfigCategory.new(admin_config_category_params)
    respond_to do |format|
      if @admin_config_category.save
        @admin_config_categories = Admin::ConfigCategory.all.paginate(:page => params[:page])
        format.html { redirect_to @admin_config_category, notice: 'Config category was successfully created.' }
        format.json { render :show, status: :created, location: @admin_config_category }
        format.js { render :layout => false }

      else
        format.html { render :new }
        format.json { render json: @admin_config_category.errors, status: :unprocessable_entity }
        format.js { render :layout => false }
      end
    end
  end

  # PATCH/PUT /admin/config_categories/1
  # PATCH/PUT /admin/config_categories/1.json
  def update
    respond_to do |format|
      if @admin_config_category.update(admin_config_category_params)
        @admin_config_categories = Admin::ConfigCategory.all.paginate(:page => params[:page])

        format.html { redirect_to @admin_config_category, notice: t(:config_category_notice_updated) }
        format.json { render :show, status: :ok, location: @admin_config_category }
        format.js { render :layout => false }
      else
        format.html { render :edit }
        format.json { render json: @admin_config_category.errors, status: :unprocessable_entity }
        format.js { render :layout => false }
      end
    end
  end

  # DELETE /admin/config_categories/1
  # DELETE /admin/config_categories/1.json
  def destroy
    @admin_config_category.destroy
    respond_to do |format|
      format.html { redirect_to admin_config_categories_url, notice: 'Config category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def duplicate
    @admin_config_category = Admin::ConfigCategory.new(@admin_config_category.attributes)
    respond_to do |format|
      format.html { redirect_to admin_config_categories_url, notice: t(:config_notice_created) }
      format.json
      format.js { render :layout => false }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_admin_config_category
    @admin_config_category = Admin::ConfigCategory.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_config_category_params
    params.require(:admin_config_category).permit(:name, :value, :description)
  end

  def current_screen
    @current_screen = Admin::ScreenName::ConfigCategory
  end
end
