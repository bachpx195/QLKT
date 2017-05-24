class Admin::RentersController < Admin::BaseController
  before_action :set_admin_renter, only: [:show, :edit, :update, :destroy, :duplicate, :edit_ajax_form, :edit_ajax_form_renters_in_room]

  # GET /admin/renters
  # GET /admin/renters.json
  def index
    @admin_renters = Admin::Renter.search(params[:search]).where(user: current_user).order(updated_at: :desc).paginate(:page => params[:page])
    @export = Admin::Renter.where(user: current_user).order(updated_at: :desc)
    respond_to do |format|
      format.html
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="Renters.xlsx"'
      }
      format.js { render :layout => false }
    end
  end

  def search
    #TODO: Search
    @admin_renters = Admin::Renter.search(params[:search]).where(user: current_user).order(updated_at: :desc).paginate(:page => params[:page])
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  # GET /admin/renters/1
  # GET /admin/renters/1.json
  def show
  end

  # GET /admin/renters/new
  def new
    @admin_renter = Admin::Renter.new
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  # GET /admin/renters/1/edit
  def edit
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  # POST /admin/renters
  # POST /admin/renters.json
  def create
    @admin_renter = Admin::Renter.new(admin_renter_params)
    @admin_renter.user = current_user
    convert_renter(@admin_renter)

    @type = params[:actionType]

    respond_to do |format|
      if @admin_renter.save
        if (@type != Admin::Constants::AJAXFORM.to_s)
          @admin_renters = Admin::Renter.where(user: current_user).order(updated_at: :desc).paginate(:page => params[:page])
        end
        format.html { redirect_to @admin_renter, notice: t(:created) }
        format.json { render :show, status: :created, location: @admin_renter }
        format.js { render :layout => false }
      else
        format.html { render :new }
        format.json { render json: @admin_renter.errors, status: :unprocessable_entity }
        format.js { render :layout => false }
      end
    end
  end

  # PATCH/PUT /admin/renters/1
  # PATCH/PUT /admin/renters/1.json
  def update
    @type = params[:actionType]
    respond_to do |format|
      if @admin_renter.update(admin_renter_params)
        convert_renter(@admin_renter)
        format.html { redirect_to @admin_renter, notice: t(:updated) }
        format.json { render :show, status: :ok, location: @admin_renter }
        format.js { render :layout => false }
      else
        format.html { render :edit }
        format.json { render json: @admin_renter.errors, status: :unprocessable_entity }
        format.js { render :layout => false }
      end
    end
  end

  def duplicate
    @admin_renter = Admin::Renter.new(@admin_renter.attributes)
    convert_renter(@admin_renter)
    render :new
  end

  # DELETE /admin/renters/1
  # DELETE /admin/renters/1.json
  def destroy
    @admin_renter.destroy
    respond_to do |format|
      format.html { redirect_to admin_renters_url, notice: t(:deleted) }
      format.json { head :no_content }
    end
  end

  def new_ajax_form
    @admin_renter = Admin::Renter.new
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  def edit_ajax_form
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  def edit_ajax_form_renters_in_room
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  def renters_in_room

    @agreements = Admin::Agreement.where(user: current_user).where(:room_id => params[:id])
    @admin_renters = Admin::Renter.where(user: current_user).where(:id => @agreements.map(&:renter_id)).paginate(:page => params[:page])
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_renter
      @admin_renter = Admin::Renter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def convert_renter(renter)
      if renter.sex==nil
        renter.sex=Admin::Constants::RENTER_SEX_UNKNOW
      end

      if renter.owner ==nil
        renter.owner = Admin::Constants::RENTER_OWNER_NOT
      end

      if renter.temporary_registration ==nil
        renter.temporary_registration = Admin::Constants::RENTER_TEMPORARY_REGISTRATION_NOT
      end
    end
    def admin_renter_params
      params.require(:admin_renter).permit(:user_id, :code, :name, :birthday, :sex, :identity_card, :issued_card, :phone, :email, :address, :career, :university, :parent_name, :parent_phone, :hometown, :temporary_registration, :owner, :description)
    end

    def current_screen
      @current_screen = Admin::ScreenName::Renter
    end
end
