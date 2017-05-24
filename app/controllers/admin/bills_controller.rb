class Admin::BillsController < Admin::BaseController
  include Commons
  before_action :set_admin_bill, only: [:show, :edit, :update, :destroy, :duplicate]
  before_action :set_bill_config, only: [:print, :print_all]

  # GET /admin/bills
  # GET /admin/bills.json
  def index
    @admin_bills = Admin::Bill.where(user_id: current_user.id).paginate(:page => params[:page]).order("created_at DESC")
    @export = Admin::Bill.all.where(user_id: current_user.id)
    respond_to do |format|
      format.html
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="Bills.xlsx"'
      }
      format.js { render :layout => false }
    end
  end

  def search
    #TODO: Search
    @admin_buildings = Admin::Building.where(users: current_user).search_by_id(params[:search])
    @admin_agreements = Admin::Agreement.first
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  # GET /admin/bills/1
  # GET /admin/bills/1.json
  def show
  end

  # GET /admin/bills/new
  def new
    @admin_bill = Admin::Bill.new
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  # GET /admin/bills/1/edit
  def edit
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  # POST /admin/bills
  # POST /admin/bills.json
  def create
    @admin_bill = Admin::Bill.new(admin_bill_params)
    @admin_bill.user = current_user
    respond_to do |format|
      if @admin_bill.save
        @admin_bills = Admin::Bill.all.where(user: current_user).paginate(:page => params[:page]).order("created_at DESC")
        format.html { redirect_to @admin_bill, notice: t(:bill_created_success) }
        format.json { render :show, status: :created, location: @admin_bill }
        format.js { render :layout => false }
      else
        format.html { render :new }
        format.json { render json: @admin_bill.errors, status: :unprocessable_entity }
        format.js { render :layout => false }
      end
    end
  end

  # PATCH/PUT /admin/bills/1
  # PATCH/PUT /admin/bills/1.json
  def update
    respond_to do |format|
      if @admin_bill.update(admin_bill_params)
        @admin_bills = Admin::Bill.all.where(user: current_user).paginate(:page => params[:page]).order("created_at DESC")
        format.html { redirect_to @admin_bill, notice: t(:bill_updated_success) }
        format.json { render :show, status: :ok, location: @admin_bill }
        format.js { render :layout => false }
      else
        format.html { render :edit }
        format.json { render json: @admin_bill.errors, status: :unprocessable_entity }
        format.js { render :layout => false }
      end
    end
  end

  # DELETE /admin/bills/1
  # DELETE /admin/bills/1.json
  def destroy
    @admin_bill.destroy
    respond_to do |format|
      @admin_bills = Admin::Bill.all.where(user: current_user).paginate(:page => params[:page])
      format.html { redirect_to admin_bills_url, notice: t(:bill_destroyed_success) }
      format.json { head :no_content }
      format.js
    end
  end

  def duplicate
    @admin_bill = Admin::Bill.new(@admin_bill.attributes)
    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  def agreements

    # PARAMS
    @month_year = "#{Time.now.month}/#{Time.now.year}"
    if (!params[:search].nil? && !params[:search][:month_year].nil?)
      @month_year = params[:search][:month_year]
    end

    @building = "0"
    if (!params[:search].nil? && !params[:search][:building].nil?)
      @building = params[:search][:building]
    end

    @room = "0"
    if (!params[:search].nil? && !params[:search][:room].nil?)
      @room = params[:search][:room]
    end

    @owner_name = ""
    if (!params[:search].nil? && !params[:search][:owner_name].nil?)
      @owner_name = params[:search][:owner_name]
    end

    @identity_card = ""
    if (!params[:search].nil? && !params[:search][:identity_card].nil?)
      @identity_card = params[:search][:identity_card]
    end

    @paid = 3
    if (!params[:search].nil? && !params[:search][:paid].nil?)
      @paid = params[:search][:paid]
    end

    @admin_buildings = buildings(current_user)
    @admin_rooms = Admin::Room.where(user: current_user).where(building_id: @building)

    @date = DateTime.strptime(@month_year, '%m/%Y')

    @admin_agreements = Admin::Agreement.select_bill_by_agreement_demo(@date.month, @date.year,@building,@room,@owner_name,@identity_card,@paid, current_user.id).paginate(:page => params[:page])
  end

  def export
    # Lấy thông tin hợp đồng
    @admin_agreement = Admin::Agreement.find(params[:id])
    # Lấy thông tin thời gian
    date = DateTime.strptime("#{params[:month]}/#{params[:year]}", '%m/%Y')
    month = date.month
    year = date.year
    last_month = (date - 1.month).month
    last_year = (date - 1.month).year
    @bill_paid =  params[:bill_paid].to_i

    # Kiểm tra xem đã có hóa đơn hay chưa?
    @admin_bill = Admin::Bill.where(user: current_user).where(agreement: @admin_agreement).where(month: month).where(year: year).first
    debt_amount = 0
    last_bill = Admin::Bill.where(user: current_user).where(room: @admin_agreement.room, month: last_month, year: last_year).first
    if !last_bill.nil?
      debt_amount += last_bill.remain_amount # Số dư nợ của hóa đơn tháng trước.
    end
    # Nếu có rồi thì là EDIT
    if (!@admin_bill.nil?)
      @admin_bill_details = Admin::BillDetail.where(bill: @admin_bill)
      # Trả về thông tin khu trọ và phòng
      @room_name = @admin_agreement.room.name
      @building_name = @admin_agreement.room.building.name
      @type = Admin::Constants::EDIT
      # Chưa có thì là NEW
    else
      @type = Admin::Constants::NEW
      # Dịch vụ theo hợp đồng.
      @admin_agreement_services = @admin_agreement.agreement_service
      @total_amount = 0
      # Lấy số điện tháng trước
      last_electricity_water = Admin::ElectricityWater.where(user: current_user).where(room: @admin_agreement.room, month: last_month, year: last_year).first
      @admin_agreement_services.each do |agreement_service|
        # bỏ qua nếu dịch vụ của hợp đồng ở trạng thái tạm dừng
        next if !agreement_service.status.nil? && agreement_service.status == Admin::Constants::AGREEMENT_SERVICE_STATUS_DEACTIVE
        case agreement_service.service.code
          # Tính tiền điện
          when Admin::Constants::SERVICES::CODE_ELECTRICITY
            # Trường hợp là dịch vụ điện và nước theo công tơ thì cập nhật số lượng = số tiêu thụ tháng trước, nếu ko có mặc định là 0
            if !last_electricity_water.nil? && last_electricity_water.total_electricity > 0
              # Nếu phòng kép thì chia số điện theo số người trong phòng
              if @admin_agreement.room.room_type == Admin::Constants::RoomType::MULTY
                people_use_services = count_people(@admin_agreement.room, agreement_service.service)
                agreement_service.amount_perservice = ((last_electricity_water.total_electricity.to_f)/people_use_services).round
                @total_amount_electricity = round_money(agreement_service.service.unit_price * last_electricity_water.total_electricity/people_use_services)
              else
                agreement_service.amount_perservice = last_electricity_water.total_electricity
                @total_amount_electricity = agreement_service.service.unit_price * last_electricity_water.total_electricity
              end
            else
              agreement_service.amount_perservice = 0
              @total_amount_electricity = 0
            end
            @total_amount = @total_amount + @total_amount_electricity
          # Tính tiền nước công tơ
          when Admin::Constants::SERVICES::CODE_WATER
            if !last_electricity_water.nil? && last_electricity_water.total_electricity > 0
              # Nếu phòng kép thì chia số điện theo số người trong phòng
              if @admin_agreement.room.room_type == Admin::Constants::RoomType::MULTY
                people_use_services = count_people(@admin_agreement.room, agreement_service.service)
                agreement_service.amount_perservice = ((last_electricity_water.total_water.to_f)/people_use_services).round
                @total_amount_water = round_money(agreement_service.service.unit_price * last_electricity_water.total_water/people_use_services)
              else
                agreement_service.amount_perservice = last_electricity_water.total_electricity
              end
            else
              agreement_service.amount_perservice = 0
              @total_amount_water = 0
            end
            @total_amount = @total_amount + @total_amount_water
          else
            @total_amount = @total_amount + agreement_service.service.unit_price * agreement_service.amount_perservice
        end
      end
      @total_amount = @total_amount + @admin_agreement.room.cost
      @admin_bill = Admin::Bill.new
      # Thiết lập thông tin Tháng + Ngày xuất
      @admin_bill.month = month
      @admin_bill.year = year
      # Thiết lập thông tin hợp đồng
      @admin_bill.agreement = @admin_agreement
      @admin_bill.room = @admin_agreement.room
      @admin_bill.bill_date = DateTime.now
      @admin_bill.other_cost = 0
      if @admin_agreement.month_pre_payment == 0
        @admin_bill.total_amount = @total_amount + @admin_agreement.room.cost + debt_amount
      else
        @admin_bill.total_amount = @total_amount + debt_amount
      end
      @admin_bill.payment_amount = 0 #@total_amount + @admin_agreement.room.cost + debt_amount
      @admin_bill.remain_amount = 0

      # Trả về thông tin khu trọ và phòng
      @room_name = @admin_agreement.room.name
      @building_name = @admin_agreement.room.building.name
    end

    @admin_bill.debt_amount = debt_amount

    respond_to do |format|
      format.html
      format.json
      format.js { render :layout => false }
    end
  end

  def export_all
    #PARAMS
    month = 12
    year = 2016
    last_month = 11
    last_year = 2016
    building_id = 21

    # Lấy danh sách toàn bộ hợp đồng theo tháng.
    @admin_agreements = Admin::Agreement.select_bill_by_agreement(month ,year, current_user.id)
    # Lặp toàn bộ danh sách hợp đồng đã có để tiến hành xuất hóa đơn.
    @admin_agreements.each do |admin_agreement|
      current_bill = Admin::Bill.where(user: current_user).where(agreement: admin_agreement).where(month: month).where(year: year).first
      if current_bill.nil?
        # Lấy toàn bộ danh sách dịch vụ đi kèm hợp đồng.
        services = admin_agreement.agreement_service
        # Tính tổng dịch vụ
        total_amount = 0
        # Thông tin điện nước tháng trước.
        last_electricity_water = Admin::ElectricityWater.where(user: current_user).where(room: admin_agreement.room, month: last_month, year: last_year).first
        services.each do |agreement_service|
          # bỏ qua nếu dịch vụ của hợp đồng ở trạng thái tạm dừng
          next if !agreement_service.status.nil? && agreement_service.status == Admin::Constants::AGREEMENT_SERVICE_STATUS_DEACTIVE
          # Trường hợp là dịch vụ điện và nước theo công tơ thì cập nhật số lượng = số tiêu thụ tháng trước, nếu ko có mặc định là 0
          case agreement_service.service.code
            when Admin::Constants::SERVICES::CODE_ELECTRICITY
              if !last_electricity_water.nil? && last_electricity_water.total_electricity > 0
                # Nếu phòng kép thì chia số điện theo số người trong phòng
                if admin_agreement.room.room_type == Admin::Constants::RoomType::MULTY
                  people_use_service = count_people(admin_agreement.room,agreement_service.service)
                  agreement_service.amount_perservice = (last_electricity_water.total_electricity.to_f/people_use_service).round
                  total_amount_electricity = round_money(agreement_service.service.unit_price * last_electricity_water.total_electricity/people_use_service)
                # Nếu phòng đơn =  số tiêu thụ tháng trước
                else
                  agreement_service.amount_perservice = last_electricity_water.total_electricity
                  total_amount_electricity = round_money(agreement_service.service.unit_price * last_electricity_water.total_electricity)
                end
              else
                agreement_service.amount_perservice = 0
                total_amount_electricity = 0
              end
              total_amount = total_amount + total_amount_electricity
            when Admin::Constants::SERVICES::CODE_WATER
              if !last_electricity_water.nil? && last_electricity_water.total_water > 0
                # Nếu phòng kép thì chia số nước theo số người trong phòng
                if admin_agreement.room.room_type == Admin::Constants::RoomType::MULTY
                  people_use_service = count_people(admin_agreement.room,agreement_service.service)
                  agreement_service.amount_perservice = (last_electricity_water.total_water.to_f/people_use_service).round
                  total_amount_water = round_money(agreement_service.service.unit_price * last_electricity_water.total_water/people_use_service)
                  # Nếu phòng đơn =  số tiêu thụ tháng trước
                else
                  agreement_service.amount_perservice = last_electricity_water.total_water
                  total_amount_water = round_money(agreement_service.service.unit_price * last_electricity_water.total_water)
                end
              else
                agreement_service.amount_perservice = 0
                total_amount_water = 0
              end
              total_amount = total_amount + total_amount_water
            else
              total_amount = total_amount + agreement_service.service.unit_price * agreement_service.amount_perservice
          end
        end
        # Cộng tiền nhà
        total_amount = total_amount + admin_agreement.room.cost
        # Lấy thông tin hóa đơn tháng trước, và lấy dư nợ
        debt_amount = 0
        last_bill = Admin::Bill.where(user: current_user).where(room: admin_agreement.room, month: last_month, year: last_year).first
        if !last_bill.nil?
          debt_amount += last_bill.remain_amount # Số dư nợ của hóa đơn tháng trước.
        end

        # Nếu hóa đơn đã có rồi, thì bỏ qua, chưa có thì mới tạo mới.

        admin_bill = Admin::Bill.new
        admin_bill.user = current_user # Chủ trọ
        # Thiết lập thông tin Tháng + Ngày xuất
        admin_bill.month = month # Tháng
        admin_bill.year = year # Năm
        # Thiết lập thông tin hợp đồng
        admin_bill.agreement = admin_agreement # Hợp đồng
        admin_bill.room = admin_agreement.room # Phòng
        admin_bill.bill_date = DateTime.now # Ngày xuất
        admin_bill.other_cost = 0 # Chi phí khác

        # Tổng tiền cần thanh toán
        total = 0
        if admin_agreement.month_pre_payment == 0 # Số tháng trả trước theo thông tin hợp đồng.
          total = total_amount + admin_agreement.room.cost + debt_amount # Tổng + Dư nợ + Tiền phòng
        else
          total = total_amount + debt_amount # Tổng + Dư nợ + 0 (Tiền phòng đã thanh toán khi làm hợp đồng)
        end
        admin_bill.total_amount = total # Tổng tiền
        admin_bill.payment_amount = total # Thanh toán mặc định = Tổng.
        admin_bill.remain_amount = 0 # Dư nợ mặc định = 0
        admin_bill.debt_amount = 0 # Dư nợ tháng này
        admin_bill.description = "" # Mô tả
        admin_bill.save!

        # Cập nhật Bill Detail.
        services.each do |agreement_service|
          # bỏ qua nếu dịch vụ của hợp đồng ở trạng thái tạm dừng
          next if !agreement_service.status.nil? && agreement_service.status == Admin::Constants::AGREEMENT_SERVICE_STATUS_DEACTIVE
          amount = agreement_service.amount_perservice
          unit_price = agreement_service.service.unit_price
          # Nếu tiền phòng
          if agreement_service.service.code == Admin::Constants::SERVICES::CODE_ROOM
            unit_price = admin_agreement.room.cost
            if !admin_agreement.month_pre_payment.nil? && admin_agreement.month_pre_payment > 0
              total = 0
            else
              total = amount * unit_price
            end
            # Nếu tiền điện
          elsif agreement_service.service.code == Admin::Constants::SERVICES::CODE_ELECTRICITY
            if !last_electricity_water.nil? && last_electricity_water.total_electricity > 0
              amount = agreement_service.amount_perservice
            else
              amount = 0
            end
            people_use_service = count_people(admin_agreement.room,agreement_service.service)
            total = round_money(agreement_service.service.unit_price * last_electricity_water.total_electricity/people_use_service)
            # Nếu tiền nước
          elsif agreement_service.service.code == Admin::Constants::SERVICES::CODE_WATER
            if !last_electricity_water.nil? && last_electricity_water.total_water > 0
              amount = agreement_service.amount_perservice
            else
              amount = 0
            end
            people_use_service = count_people(admin_agreement.room,agreement_service.service)
            total = round_money(agreement_service.service.unit_price * last_electricity_water.total_water/people_use_service)
            # Nếu dịch vụ khác
          else
            total = amount * unit_price
          end

          # Tạo mới bill detail theo service.
          bill_detail = Admin::BillDetail.new
          bill_detail.user = current_user
          bill_detail.bill = admin_bill
          bill_detail.service = agreement_service.service
          bill_detail.amount = amount
          bill_detail.unit_price = unit_price
          bill_detail.total = total
          bill_detail.save!
        end

        # Cập nhật lại số tháng đã thanh toán trước -1. (Nghiệp vụ)
        admin_agreement = Admin::Agreement.find(admin_bill.agreement.id)
        if !admin_agreement.month_pre_payment.nil? && admin_agreement.month_pre_payment > 0
          admin_agreement.month_pre_payment -= 1
          if admin_agreement.month_pre_payment == 0
            admin_agreement.pre_payment = 0
          end
          admin_agreement.save!
        end
      end
    end

    # Xuất Excel cho n sheet tương ứng với n cái hợp đồng với teamplate là hóa đơn.
  end

  def exported
    # Trường hợp thêm mới
    if (params[:admin_bill][:id] == '')
      @admin_bill = Admin::Bill.new(admin_bill_params)
      @admin_bill.user = current_user

      respond_to do |format|
        if @admin_bill.save
          # Lưu thông tin vào bảng chi tiết hóa đơn.
          if (!params[:admin_services].nil?)
            @services = params.require(:admin_services)
            @services[:id].each_with_index do |item, index|
              bill_detail = Admin::BillDetail.new
              bill_detail.user = current_user
              bill_detail.bill = @admin_bill
              service = Admin::Service.find(item)
              bill_detail.service = service
              bill_detail.amount = @services[:amount][index].gsub(".", "")
              bill_detail.unit_price = @services[:unit_price][index].gsub(".", "")
              bill_detail.total = @services[:total][index].gsub(".", "")
              bill_detail.save!
            end
          end

          # Cập nhật lại số tháng đã thanh toán trước -1. (Nghiệp vụ)
          admin_agreement = Admin::Agreement.find(@admin_bill.agreement.id)
          if !admin_agreement.month_pre_payment.nil? && admin_agreement.month_pre_payment > 0
            admin_agreement.month_pre_payment -= 1
            if admin_agreement.month_pre_payment == 0
              admin_agreement.pre_payment = 0
            end
            admin_agreement.save!
          end

          # PARAMS
          @month_year = "#{Time.now.month}/#{Time.now.year}"
          if (!params[:search].nil? && !params[:search][:month_year].nil?)
            @month_year = params[:search][:month_year]
          end

          @building = "0"
          if (!params[:search].nil? && !params[:search][:building].nil?)
            @building = params[:search][:building]
          end

          @room = "0"
          if (!params[:search].nil? && !params[:search][:room].nil?)
            @room = params[:search][:room]
          end

          @admin_buildings = buildings(current_user)
          @admin_rooms = Admin::Room.where(user: current_user).where(building_id: @building)

          @admin_agreements = Admin::Agreement.select_bill_by_agreement(@admin_bill.month, @admin_bill.year, current_user.id).paginate(:page => params[:page])

          format.js { render :layout => false }
        else
          format.js { render :layout => false }
        end
      end
      # Trường hợp sửa
    else
      respond_to do |format|
        @admin_bill = Admin::Bill.find(params[:admin_bill][:id])
        if @admin_bill.update(admin_bill_params)

          # Xóa bỏ dịch vụ đã có.
          Admin::BillDetail.where(bill: @admin_bill).delete_all

          # Thêm mới nếu có dịch vụ
          if (!params[:admin_services].nil?)
            @services = params.require(:admin_services)
            @services[:id].each_with_index do |item, index|
              bill_detail = Admin::BillDetail.new
              bill_detail.user = current_user
              bill_detail.bill = @admin_bill
              service = Admin::Service.find(item)
              bill_detail.service = service
              bill_detail.amount = @services[:amount][index].gsub(".", "")
              bill_detail.unit_price = @services[:unit_price][index].gsub(".", "")
              bill_detail.total = @services[:amount][index].gsub(".", "").to_i * @services[:unit_price][index].gsub(".", "").to_i
              bill_detail.save!
            end
          end

          # Cập nhật lại số tháng đã thanh toán trước -1. (Nghiệp vụ)
          admin_agreement = Admin::Agreement.find(@admin_bill.agreement.id)
          if !admin_agreement.month_pre_payment.nil? && admin_agreement.month_pre_payment > 0
            admin_agreement.month_pre_payment -= 1
            if admin_agreement.month_pre_payment == 0
              admin_agreement.pre_payment = 0
            end
            admin_agreement.save!
          end

          # PARAMS
          @month_year = "#{Time.now.month}/#{Time.now.year}"
          if (!params[:search].nil? && !params[:search][:month_year].nil?)
            @month_year = params[:search][:month_year]
          end

          @building = "0"
          if (!params[:search].nil? && !params[:search][:building].nil?)
            @building = params[:search][:building]
          end

          @room = "0"
          if (!params[:search].nil? && !params[:search][:room].nil?)
            @room = params[:search][:room]
          end

          @admin_buildings = buildings(current_user)
          @admin_rooms = Admin::Room.where(user: current_user).where(building_id: @building)

          @admin_agreements = Admin::Agreement.select_bill_by_agreement(@admin_bill.month, @admin_bill.year, current_user.id).paginate(:page => params[:page])

          format.js { render :layout => false }
        else
          format.js { render :layout => false }
        end
      end
    end
  end

  def print
    @admin_bill = Admin::Bill.find(params[:bill_id])
    if !@admin_bill.description.blank?
      @admin_bill.description = "Ghi chú: " + @admin_bill.description
    end
    # TODO: Dư nợ phải là của tháng trước chứ không phải tháng hiện tại.

    respond_to do |format|
      format.xlsx {
        response.headers['Content-Disposition'] = "attachment; filename='#{@admin_bill.code}-#{@admin_bill.month}-#{@admin_bill.year}.xlsx'"
      }
    end
  end

  def print_all
    # TODO params
    month = 1
    year = 2017

    @admin_bills = Admin::Bill.where(user: current_user).where(month: month).where(year: year)
    # TODO: Dư nợ phải là của tháng trước chứ không phải tháng hiện tại.
    respond_to do |format|
      format.xlsx {
        response.headers['Content-Disposition'] = "attachment; filename='HOADON-#{month}-#{year}.xlsx'"
      }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_admin_bill
    @admin_bill = Admin::Bill.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_bill_params
    strMonthYear = params[:admin_bill][:month_year]
    params.require(:admin_bill)[:month] = strMonthYear.split('/').first
    params.require(:admin_bill)[:year] = strMonthYear.split('/').last

    params[:admin_bill][:other_cost] = params[:admin_bill][:other_cost].gsub(".", "")
    params[:admin_bill][:debt_amount] = params[:admin_bill][:debt_amount].gsub(".", "")
    params[:admin_bill][:total_amount] = params[:admin_bill][:total_amount].gsub(".", "")
    params[:admin_bill][:payment_amount] = params[:admin_bill][:payment_amount].gsub(".", "")
    # Đổi dấu dư nợ, phục vụ cho việc tính toán tháng sau.
    remain_amount = params[:admin_bill][:remain_amount]
    if (remain_amount.include? "-")
      params[:admin_bill][:debt_amount] = remain_amount.sub("-", "").gsub(".", "")
    else
      params[:admin_bill][:debt_amount] = "-#{remain_amount}".gsub(".", "")
    end

    params[:admin_bill][:remain_amount] = params[:admin_bill][:remain_amount].gsub(".", "")

    params.require(:admin_bill).permit(:user_id, :agreement_id, :room_id, :month, :year, :code, :bill_date, :other_cost, :debt_amount, :total_amount, :payment_amount, :remain_amount, :description)

  end

  # đếm số người dùng dịch vụ trong phòng
  def count_people(room)
    return people_in_room = Admin::Agreement.where(user: current_user).where(room: room).where.not(status: Admin::Constants::AGREEMENT_STATUS_INVALID).count
  end

  # đếm số người dùng dịch vu trong phòng
  def count_people(room, service)
    # số người đang dùng dịch vụ
    people_use_service = 0
    # đếm sô hợp đồng hiện tại có trong phòng
    agreement_in_rooms = Admin::Agreement.where(user: current_user).where(room: room).where(status: Admin::Constants::AGREEMENT_STATUS_VALID)
    agreement_in_rooms.each do |agreement|
      agreement_services = agreement.agreement_service
      agreement_services.each do |agreement_service|
        if agreement_service.service == service && agreement_service.status != Admin::Constants::AGREEMENT_SERVICE_STATUS_DEACTIVE
          people_use_service = people_use_service+ 1
        end
      end
    end
    return people_use_service
  end

  def set_bill_config
    @config_building_name = session[:TEN]
    @config_building_address = session[:DIACHI]
    @config_building_phone = session[:DIENTHOAI]
    @config_bill_title = session[:TIEUDEHOADON]
    @config_bill_note = session[:GHICHUHOADON]
    @config_bill_owner = session[:CHUTRO]
    @config_bill_province = session[:TINHTHANH]
  end

  def current_screen
    @current_screen = Admin::ScreenName::Bill
  end

end
