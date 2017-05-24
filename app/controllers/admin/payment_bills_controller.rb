class Admin::PaymentBillsController < Admin::BaseController
  include Commons
  before_action :set_admin_payment_bill, only: [:show, :edit, :update, :destroy, :duplicate]
  before_action :set_admin_buildings, only: [:new, :edit, :duplicate]

  # GET /admin/payment_bills
  # GET /admin/payment_bills.json
  def index
    @month_year_from = "#{Time.now.month}/#{Time.now.year}"
    if (!params[:search].nil? && !params[:search][:month_year_from].nil?)
      @month_year_from = params[:search][:month_year_from]
    end

    @month_year_end = "#{Time.now.month}/#{Time.now.year}"
    if (!params[:search].nil? && !params[:search][:month_year_end].nil?)
      @month_year_end = params[:search][:month_year_end]
    end

    @building = "0"
    if (!params[:search].nil? && !params[:search][:building].nil?)
      @building = params[:search][:building]
    end
    if params.include?(:search)
      @admin_buildings = Admin::Building.where(user: current_user).search_by_id(params[:search])
    else
      @admin_buildings = buildings(current_user)
    end

    @admin_payment_bills = Admin::PaymentBill.where(user: current_user).order(building_id: :asc, updated_at: :desc).paginate(:page => params[:page])

    @export = Admin::PaymentBill.where(user: current_user).order(building_id: :asc, updated_at: :desc)

    respond_to do |format|
      format.html
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="PhieuChi.xlsx"'
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

  # GET /admin/payment_bills/1
  # GET /admin/payment_bills/1.json
  def show
  end

  # GET /admin/payment_bills/new
  def new
    @admin_payment_bill = Admin::PaymentBill.new
    @admin_payment_bill.payment_date = Time.now
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  # GET /admin/payment_bills/1/edit
  def edit
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
  end
  end

  # POST /admin/payment_bills
  # POST /admin/payment_bills.json
  def create
    @admin_payment_bill = Admin::PaymentBill.new(admin_payment_bill_params)
    @admin_payment_bill.user = current_user
    respond_to do |format|
      if @admin_payment_bill.save
        @admin_payment_bills = Admin::PaymentBill.where(user: current_user).order(building_id: :asc, updated_at: :desc).paginate(:page => params[:page])
        @admin_buildings = buildings(current_user)


        format.html { redirect_to @admin_payment_bill, notice: t(:payment_bill_was_successfully_created) }
        format.json { render :show, status: :created, location: @admin_payment_bill }
        format.js { render :layout => false }
      else
        format.html { render :new }
        format.json { render json: @admin_payment_bill.errors, status: :unprocessable_entity }
        format.js { render :layout => false }
      end
    end
  end

  # PATCH/PUT /admin/payment_bills/1
  # PATCH/PUT /admin/payment_bills/1.json
  def update
    respond_to do |format|
      if @admin_payment_bill.update(admin_payment_bill_params)
        @admin_buildings = buildings(current_user)

        format.html { redirect_to @admin_payment_bill, notice: t(:payment_bill_was_successfully_updated) }
        format.json { render :show, status: :ok, location: @admin_payment_bill }
        format.js { render :layout => false }
      else
        format.html { render :edit }
        format.json { render json: @admin_payment_bill.errors, status: :unprocessable_entity }
        format.js { render :layout => false }
      end
    end
  end

  # DELETE /admin/payment_bills/1
  # DELETE /admin/payment_bills/1.json
  def destroy
    @admin_payment_bill.destroy
    respond_to do |format|
      format.html { redirect_to admin_payment_bills_url, notice: t(:payment_bill_was_successfully_destroyed) }
      format.json { head :no_content }
    end
  end

  def duplicate
    @admin_payment_bill = Admin::PaymentBill.new(@admin_payment_bill.attributes)
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_payment_bill
      @admin_payment_bill = Admin::PaymentBill.find(params[:id])
    end

    def set_admin_buildings
      @admin_buildings = buildings(current_user)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_payment_bill_params
      params[:admin_payment_bill][:amount] = params[:admin_payment_bill][:amount].gsub(".", "")
      params[:admin_payment_bill][:unit_price] = params[:admin_payment_bill][:unit_price].gsub(".", "")
      params[:admin_payment_bill][:payment] = params[:admin_payment_bill][:payment].gsub(".", "")
      params.require(:admin_payment_bill).permit(:building_id, :user_id, :code, :name, :payment_date, :payment_type, :amount, :unit, :unit_price, :payment, :description)
    end

    def current_screen
      @current_screen = Admin::ScreenName::PaymentBill
    end
end
