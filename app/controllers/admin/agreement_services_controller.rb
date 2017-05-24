class Admin::AgreementServicesController < Admin::BaseController
  before_action :set_admin_agreement_service, only: [:show, :edit, :update, :destroy]

  # GET /admin/agreement_services
  # GET /admin/agreement_services.json
  def index
    @admin_agreement_services = Admin::AgreementService.all
  end

  def search
    #TODO: Search
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  # GET /admin/agreement_services/1
  # GET /admin/agreement_services/1.json
  def show
  end

  # GET /admin/agreement_services/new
  def new
    @admin_agreement_service = Admin::AgreementService.new
  end

  # GET /admin/agreement_services/1/edit
  def edit
  end

  # POST /admin/agreement_services
  # POST /admin/agreement_services.json
  def create
    @admin_agreement_service = Admin::AgreementService.new(admin_agreement_service_params)

    respond_to do |format|
      if @admin_agreement_service.save
        format.html { redirect_to @admin_agreement_service, notice: 'Agreement service was successfully created.' }
        format.json { render :show, status: :created, location: @admin_agreement_service }
      else
        format.html { render :new }
        format.json { render json: @admin_agreement_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/agreement_services/1
  # PATCH/PUT /admin/agreement_services/1.json
  def update
    respond_to do |format|
      if @admin_agreement_service.update(admin_agreement_service_params)
        format.html { redirect_to @admin_agreement_service, notice: 'Agreement service was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_agreement_service }
      else
        format.html { render :edit }
        format.json { render json: @admin_agreement_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/agreement_services/1
  # DELETE /admin/agreement_services/1.json
  def destroy
    @admin_agreement_service.destroy
    respond_to do |format|
      format.html { redirect_to admin_agreement_services_url, notice: 'Agreement service was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_agreement_service
      @admin_agreement_service = Admin::AgreementService.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_agreement_service_params
      params.require(:admin_agreement_service).permit(:user_id, :agreement_id, :service_id, :amount_perservice)
    end
end
