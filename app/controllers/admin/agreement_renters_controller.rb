class Admin::AgreementRentersController < Admin::BaseController
  before_action :set_admin_agreement_renter, only: [:show, :edit, :update, :destroy]

  # GET /admin/agreement_renters
  # GET /admin/agreement_renters.json
  def index
    @admin_agreement_renters = Admin::AgreementRenter.all
  end

  def search
    #TODO: Search
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  # GET /admin/agreement_renters/1
  # GET /admin/agreement_renters/1.json
  def show
  end

  # GET /admin/agreement_renters/new
  def new
    @admin_agreement_renter = Admin::AgreementRenter.new
  end

  # GET /admin/agreement_renters/1/edit
  def edit
  end

  # POST /admin/agreement_renters
  # POST /admin/agreement_renters.json
  def create
    @admin_agreement_renter = Admin::AgreementRenter.new(admin_agreement_renter_params)

    respond_to do |format|
      if @admin_agreement_renter.save
        format.html { redirect_to @admin_agreement_renter, notice: 'Agreement renter was successfully created.' }
        format.json { render :show, status: :created, location: @admin_agreement_renter }
      else
        format.html { render :new }
        format.json { render json: @admin_agreement_renter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/agreement_renters/1
  # PATCH/PUT /admin/agreement_renters/1.json
  def update
    respond_to do |format|
      if @admin_agreement_renter.update(admin_agreement_renter_params)
        format.html { redirect_to @admin_agreement_renter, notice: 'Agreement renter was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_agreement_renter }
      else
        format.html { render :edit }
        format.json { render json: @admin_agreement_renter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/agreement_renters/1
  # DELETE /admin/agreement_renters/1.json
  def destroy
    @admin_agreement_renter.destroy
    respond_to do |format|
      format.html { redirect_to admin_agreement_renters_url, notice: 'Agreement renter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_agreement_renter
      @admin_agreement_renter = Admin::AgreementRenter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_agreement_renter_params
      params.require(:admin_agreement_renter).permit(:user_id, :agreement_id, :renter_id)
    end
end
