class Admin::ConfigsController < Admin::BaseController
  before_action :set_admin_config, only: [:show, :edit, :update, :destroy, :duplicate]

  # GET /admin/configs
  # GET /admin/configs.json
  def index
    @admin_configs = Admin::Config.search(params[:search]).where(user: current_user).paginate(:page => params[:page])
    @export = Admin::Config.all
    respond_to do |format|
      format.html
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="Configs.xlsx"'
      }
      format.js { render :layout => false }
    end
  end

  def search
    @admin_configs = Admin::Config.search(params[:search]).where(user: current_user).paginate(:page => params[:page])
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  def save
    #CONFIG_TEN
    @config = Admin::Config.find_by(code: Admin::Constants::CONFIG_TEN)
    @config.value = params[:configs][:name]
    @config.save!

    #CONFIG_DIACHI
    @config = Admin::Config.find_by(code: Admin::Constants::CONFIG_DIACHI)
    @config.value = params[:configs][:address]
    @config.save!

    #CONFIG_DIENTHOAI
    @config = Admin::Config.find_by(code: Admin::Constants::CONFIG_DIENTHOAI)
    @config.value = params[:configs][:phone]
    @config.save!

    #CONFIG_CHUTRO
    @config = Admin::Config.find_by(code: Admin::Constants::CONFIG_CHUTRO)
    @config.value = params[:configs][:owner]
    @config.save!

    #CONFIG_TIEUDEHOADON
    @config = Admin::Config.find_by(code: Admin::Constants::CONFIG_TIEUDEHOADON)
    @config.value = params[:configs][:bill_title]
    @config.save!

    #CONFIG_TINHTHANH
    @config = Admin::Config.find_by(code: Admin::Constants::CONFIG_TINHTHANH)
    @config.value = params[:configs][:bill_province]
    @config.save!

    #CONFIG_GHICHUHOADON
    @config = Admin::Config.find_by(code: Admin::Constants::CONFIG_GHICHUHOADON)
    @config.value = params[:configs][:bill_note]
    @config.save!

    #CONFIG_CHUCNANGCOPY
    @config = Admin::Config.find_by(code: Admin::Constants::CONFIG_CHUCNANGCOPY)
    if params[:configs][:copy]
      @config.value = '1'
    else
      @config.value = '0'
    end
    @config.save!

    set_sessions()

    respond_to do |format|
      format.html { redirect_to admin_configs_path }
      format.json
    end
  end

  # GET /admin/configs/1
  # GET /admin/configs/1.json
  def show
  end

  # GET /admin/configs/new
  def new
    @admin_config = Admin::Config.new
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  # GET /admin/configs/1/edit
  def edit
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  # POST /admin/configs
  # POST /admin/configs.json
  def create
    @admin_config = Admin::Config.new(admin_config_params)
    @admin_config.user = current_user
    respond_to do |format|
      if @admin_config.save
        @admin_configs = Admin::Config.where(user: current_user).paginate(:page => params[:page])
        format.html { redirect_to @admin_config, notice: t(:config_notice_created) }
        format.json { render :show, status: :created, location: @admin_config }
        format.js { render :layout => false }

      else
        format.html { render :new }
        format.json { render json: @admin_config.errors, status: :unprocessable_entity }
        format.js { render :layout => false }
      end
    end
  end

  # PATCH/PUT /admin/configs/1
  # PATCH/PUT /admin/configs/1.json
  def update
    respond_to do |format|
      if @admin_config.update(admin_config_params)
        format.html { redirect_to @admin_config, notice: t(:config_notice_updated) }
        format.json { render :show, status: :ok, location: @admin_config }
        format.js { render :layout => false }
      else
        format.html { render :edit }
        format.json { render json: @admin_config.errors, status: :unprocessable_entity }
        format.js { render :layout => false }
      end
    end
  end

  # DELETE /admin/configs/1
  # DELETE /admin/configs/1.json
  def destroy
    @admin_config.destroy
    respond_to do |format|
      format.html { redirect_to admin_configs_url, notice: t(:config_notice_destroyed) }
      format.json { head :no_content }
    end
  end

  def duplicate
    @admin_config = Admin::Config.new(@admin_config.attributes)
    respond_to do |format|
      format.html { redirect_to admin_configs_url, notice: t(:config_notice_created) }
      format.json
      format.js { render :layout => false }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_config
      @admin_config = Admin::Config.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_config_params
      params.require(:admin_config).permit(:config_category_id, :user_id, :code, :value, :description)
    end

    def current_screen
      @current_screen = Admin::ScreenName::Config
    end
end
