class Admin::BillDetailsController < Admin::BaseController
  before_action :set_admin_bill_detail, only: [:show, :edit, :update, :destroy,:duplicate]

  # GET /admin/bill_details
  # GET /admin/bill_details.json
  def index
    @admin_bill_details = Admin::BillDetail.where(user_id: current_user.id).paginate(:page => params[:page])
    @export = Admin::BillDetail.all.where(user_id: current_user.id)
    respond_to do |format|
      format.html
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="BillDetails.xlsx"'
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

  # GET /admin/bill_details/1
  # GET /admin/bill_details/1.json
  def show
  end

  # GET /admin/bill_details/new
  def new
    @admin_bill_detail = Admin::BillDetail.new
    @current_user = current_user
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  # GET /admin/bill_details/1/edit
  def edit
    respond_to do |format|
      format.html
      format.json
      format.js {render :layout => false }
    end
  end

  # POST /admin/bill_details
  # POST /admin/bill_details.json
  def create
    @admin_bill_detail = Admin::BillDetail.new(admin_bill_detail_params)
    @admin_bill_detail.user = current_user
    respond_to do |format|
      if @admin_bill_detail.save
        @admin_bill_details = Admin::BillDetail.paginate(:page => params[:page])
        format.html { redirect_to @admin_bill_detail, notice: t(:bill_details_created_success) }
        format.json { render :show, status: :created, location: @admin_bill_detail }
        format.js { render :layout => false }
      else
        format.html { render :new }
        format.json { render json: @admin_bill_detail.errors, status: :unprocessable_entity }
        format.js {render :layout => false}
      end
    end
  end

  # PATCH/PUT /admin/bill_details/1
  # PATCH/PUT /admin/bill_details/1.json
  def update
    respond_to do |format|
      if @admin_bill_detail.update(admin_bill_detail_params)
        @admin_bill_details = Admin::BillDetail.where(user_id: current_user.id).paginate(:page => params[:page])
        format.html { redirect_to @admin_bill_detail, notice: t(:bill_details_updated_success) }
        format.json { render :show, status: :ok, location: @admin_bill_detail }
        format.js {render :layout => false }
      else
        format.html { render :edit }
        format.json { render json: @admin_bill_detail.errors, status: :unprocessable_entity }
        format.js {render :layout => false }
      end
    end
  end

  # DELETE /admin/bill_details/1
  # DELETE /admin/bill_details/1.json
  def destroy
    @admin_bill_detail.destroy
    respond_to do |format|
      format.html { redirect_to admin_bill_details_url, notice: t(:bill_details_destroyed_success) }
      format.json { head :no_content }
    end
  end

  def duplicate
    @admin_bill_detail = Admin::BillDetail.new(@admin_bill_detail.attributes)
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_bill_detail
      @admin_bill_detail = Admin::BillDetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_bill_detail_params
      params.require(:admin_bill_detail).permit(:user_id, :bill_id, :service_id, :amount, :unit_price, :total)
    end
end
