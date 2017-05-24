class Admin::FunctionsController < Admin::BaseController
  before_action :set_admin_function, only: [:show, :edit, :update, :destroy]

  # GET /admin/functions
  # GET /admin/functions.json
  def index
    @admin_functions = Admin::Function.all
  end

  def search
    #TODO: Search
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  # GET /admin/functions/1
  # GET /admin/functions/1.json
  def show
  end

  # GET /admin/functions/new
  def new
    @admin_function = Admin::Function.new
  end

  # GET /admin/functions/1/edit
  def edit
  end

  # POST /admin/functions
  # POST /admin/functions.json
  def create
    @admin_function = Admin::Function.new(admin_function_params)

    respond_to do |format|
      if @admin_function.save
        format.html { redirect_to @admin_function, notice: 'Function was successfully created.' }
        format.json { render :show, status: :created, location: @admin_function }
      else
        format.html { render :new }
        format.json { render json: @admin_function.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/functions/1
  # PATCH/PUT /admin/functions/1.json
  def update
    respond_to do |format|
      if @admin_function.update(admin_function_params)
        format.html { redirect_to @admin_function, notice: 'Function was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_function }
      else
        format.html { render :edit }
        format.json { render json: @admin_function.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/functions/1
  # DELETE /admin/functions/1.json
  def destroy
    @admin_function.destroy
    respond_to do |format|
      format.html { redirect_to admin_functions_url, notice: 'Function was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_function
      @admin_function = Admin::Function.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_function_params
      params.require(:admin_function).permit(:parent_id, :name, :controller, :description)
    end

    def current_screen
      @current_screen = Admin::ScreenName::Function
    end
end
