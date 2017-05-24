module ApplicationHelper

  def default_sessions
    session[:TEN] = ''
    session[:DIACHI] = ''
    session[:DIENTHOAI] = ''
    session[:CHUTRO] = ''
    session[:TIEUDEHOADON] = ''
    session[:TINHTHANH] = ''
    session[:GHICHUHOADON] = ''
    session[:CHUCNANGCOPY] = ''

    session[:TEN_LABEL] = ''
    session[:DIACHI_LABEL] = ''
    session[:DIENTHOAI_LABEL] = ''
    session[:CHUTRO_LABEL] = ''
    session[:TIEUDEHOADON_LABEL] = ''
    session[:TINHTHANH_LABEL] = ''
    session[:GHICHUHOADON_LABEL] = ''
    session[:CHUCNANGCOPY_LABEL] = ''
  end

  def set_sessions
    configs = Admin::Config.where(user: current_user)
    if !configs.nil? || configs.count
      configs.each do |config|
        case config.code
        when Admin::Constants::CONFIG_TEN
          session[:TEN] = config.value
          session[:TEN_LABEL] = config.label
        when Admin::Constants::CONFIG_DIACHI
          session[:DIACHI] = config.value
          session[:DIACHI_LABEL] = config.label
        when Admin::Constants::CONFIG_DIENTHOAI
          session[:DIENTHOAI] = config.value
          session[:DIENTHOAI_LABEL] = config.label
        when Admin::Constants::CONFIG_GHICHUHOADON
          session[:GHICHUHOADON] = config.value
          session[:GHICHUHOADON_LABEL] = config.label
        when Admin::Constants::CONFIG_CHUTRO
          session[:CHUTRO] = config.value
          session[:CHUTRO_LABEL] = config.label
        when Admin::Constants::CONFIG_TIEUDEHOADON
          session[:TIEUDEHOADON] = config.value
          session[:TIEUDEHOADON_LABEL] = config.label
        when Admin::Constants::CONFIG_GHICHUHOADON
          session[:GHICHUHOADON] = config.value
          session[:GHICHUHOADON_LABEL] = config.label
        when Admin::Constants::CONFIG_TINHTHANH
          session[:TINHTHANH] = config.value
          session[:TINHTHANH_LABEL] = config.label
        when Admin::Constants::CONFIG_CHUCNANGCOPY
          session[:CHUCNANGCOPY] = config.value
          session[:CHUCNANGCOPY_LABEL] = config.label
        else
        end
      end
    end
  end

  def format_month_year(step)

    monthYear = []
    for i in 0..step
      preYear = Time.now.year-i
      year = Time.now.year
      month = Time.now.month

      # Nếu year < Hiện tại thì luôn add vào.
      if (preYear < year)
        12.downto(1) { |j|
          monthYear << OpenStruct.new(id: "#{j}/#{preYear}", name: "Tháng #{j}/#{preYear}")
        }
      elsif year == Time.now.year
        if month == 12
          monthYear << OpenStruct.new(id: "1/#{preYear+1}", name: "Tháng 1/#{preYear+1}")
          month.downto(1) { |j|
            monthYear << OpenStruct.new(id: "#{j}/#{preYear}", name: "Tháng #{j}/#{preYear}")
          }
        else
          monthYear << OpenStruct.new(id: "#{month+1}/#{preYear}", name: "Tháng #{month+1}/#{preYear}")
          month.downto(1) { |j|
            monthYear << OpenStruct.new(id: "#{j}/#{preYear}", name: "Tháng #{j}/#{preYear}")
          }
        end
      end

    end

    return monthYear
  end

  def format_month_year(month, year)
    if (month.nil? || year.nil?)
      return ''
    else
      return "#{month}/#{year}"
    end
  end

  def format_day_month_year(day, month, year)
    if (day.nil? || month.nil? || year.nil?)
      return ''
    else
      return "#{day}/#{month}/#{year}"
    end
  end

  def format_money(str, has_unit = true)
    if (has_unit)
      if str == 0 || str.nil?
        ''
      else
        number_with_delimiter(str, delimiter: ".", separator: ",")+" VNĐ"
      end
    else
      if str == 0 || str.nil?
        ''
      else
        number_with_delimiter(str, delimiter: ".", separator: ",")
      end
    end
  end

  def round_money(money)
    return money/1000*1000
  end

  def format_month(str)
    if str == 0
      "Không thời hạn"
    else
      "#{str} tháng"
    end
  end

  def format_cycle_month(str)
    if str == 0
      "1 tháng/lần"
    else
      "#{str} tháng/lần"
    end
  end

  def format_stt(str)
    case str
      when 0
        "Nháp"
      when 1
        "Còn hiệu lực"
      when 2
        "Hết hiệu lực"
      else
        ""
    end
  end
  #Luan_kieuchi
  def payment_type_collection
    return [
        [t(:payment_bill_selected), Admin::Constants::PaymentType::NONE],
        [Admin::Constants::PaymentType::MONTH_DAILY_STR, Admin::Constants::PaymentType::MONTH_DAILY],
        [Admin::Constants::PaymentType::REPLACEMENT_STR, Admin::Constants::PaymentType::REPLACEMENT],
        [Admin::Constants::PaymentType::NEW_STR, Admin::Constants::PaymentType::NEW],
        [Admin::Constants::PaymentType::OTHER_STR, Admin::Constants::PaymentType::OTHER]
    ]
  end

  def convert_payment_type(str)
    if str!= nil
      if str == Admin::Constants::PaymentType::MONTH_DAILY
        Admin::Constants::PaymentType::MONTH_DAILY_STR
      elsif str == Admin::Constants::PaymentType::REPLACEMENT
        Admin::Constants::PaymentType::REPLACEMENT_STR
      elsif str == Admin::Constants::PaymentType::NEW
        Admin::Constants::PaymentType::NEW_STR
      else
        Admin::Constants::PaymentType::OTHER_STR
      end
    end
  end
  #Luan_donvi

  #thinhlv
  def room_type_collection
    return [
        # [t(:room_spaceholder_building), Admin::Constants::RoomType::SIMPLE],
        [format_room_type(Admin::Constants::RoomType::SIMPLE), Admin::Constants::RoomType::SIMPLE],
        [format_room_type(Admin::Constants::RoomType::MULTY), Admin::Constants::RoomType::MULTY]
    ]
  end
  def room_status_collection
    return [
        [format_room_stt(Admin::Constants::ROOM_EMPTY), Admin::Constants::ROOM_EMPTY],
        [format_room_stt(Admin::Constants::ROOM_RENTED), Admin::Constants::ROOM_RENTED],
        [format_room_stt(Admin::Constants::ROOM_DEPOSITED), Admin::Constants::ROOM_DEPOSITED],
        [format_room_stt(Admin::Constants::ROOM_RENTED_DEPOSITED), Admin::Constants::ROOM_RENTED_DEPOSITED]
    ]
  end

  def month_prepayment_collection
    return [
        [t(:agreement_month_pre_payment_selected), 0],
        ["1 tháng", 1],
        ["2 tháng", 2],
        ["3 tháng", 3],
        ["6 tháng", 6],
        ["1 năm", 12],
        ["1.5 năm", 18],
        ["2 năm", 24]
    ]
  end

  def convert_datetime(str)
    if str!=nil
      str.strftime("%d/%m/%Y")
    end
  end

  def format_date_ddMMyyy(str)
    if str!=nil
      str.strftime("%d/%m/%Y")
    else
      ''
    end
  end

  def format_date_ddMMyyyHHmm(str)
    if str!=nil
      str.strftime("%d/%m/%Y %H:%M")
    else
      ''
    end
  end

  def format_room_type(stt, short = false)
    if short
      if stt == 0
        "ĐƠN"
      elsif stt == 1
        "KTX"
      end
    else
      if stt==0
        "Phòng ĐƠN"
      elsif stt==1
        "Phòng KTX"
      end
    end
  end

  def format_room_stt(stt)
    if stt == Admin::Constants::ROOM_EMPTY
      "Còn trống"
    elsif stt == Admin::Constants::ROOM_RENTED
      "Đã được thuê"
    elsif stt == Admin::Constants::ROOM_DEPOSITED
      "Đã đặt cọc"
    elsif stt == Admin::Constants::ROOM_RENTED_DEPOSITED
      "Báo chuyển ra"
    end
  end
  def format_room_device_status(stt)
    if stt==0
      "Sử dụng tốt"
    elsif stt==1
      "Mới 50%"
    elsif stt==3
      "Hỏng"
    end
  end

  def get_agreement_code(index)
    time = Time.now.strftime("%d%m%y").to_s
    unless index.nil?
      if index < 10
        "HĐ"+time+"-00#{index}"
      elsif index < 100
        "HĐ"+time+"-0#{index}"
      else
        "HĐ"+time+"-#{index}"
      end
    end
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end

  def in_words(int, is_odd, first)
    numbers_to_name = {
        1000000000 => "tỉ",
        1000000 => "triệu",
        1000 => "nghìn",
        100 => "trăm",
        90 => "chín mươi",
        80 => "tám mươi",
        70 => "bảy mươi",
        60 => "sáu mươi",
        50 => "năm mươi",
        40 => "bốn mươi",
        30 => "ba mươi",
        20 => "hai mươi",
        15 =>"mười lăm",
        10 => "mười",
        9 => "chín",
        8 => "tám",
        7 => "bảy",
        6 => "sáu",
        5 => "năm",
        4 => "bốn",
        3 => "ba",
        2 => "hai",
        1 => "một"
    }
    str = ""
    numbers_to_name.each do |num, name|


      #puts "NUM: #{num}"
      #puts "INT: #{int}"

      if int == 0
        return ''
      elsif int.to_s.length == 1 && int/num > 0
        if !first && is_odd
          return str + "lẻ #{name}"
        else
          return str + "#{name}"
        end
      elsif int < 100 && int/num > 0

        return str + "#{name}" if int%num == 0

        return str + "#{name} " + in_words(int%num, false, false)

      elsif int/num > 0
        if num.to_s.length > ((int%num).to_s.length + 1)
          if num.to_s.length > ((int%num).to_s.length + 2)
            return str + in_words(int/num, false, false) + " #{name} không trăm lẻ " + in_words(int%num, true, false)
          else
            return str + in_words(int/num, false, false) + " #{name} không trăm " + in_words(int%num, true, false)
          end
        else
          return str + in_words(int/num, false, false) + " #{name} " + in_words(int%num, true, false)
        end
      end
    end

  end

  def convert_money_to_string(s)
    s = in_words(s, true, true)
    s = s.sub("mươi năm", "mươi lăm")
    s = s.sub("trăm không trăm", "trăm")
    s = s.sub("mươi một", "mươi mốt")
    s = s.sub("lẻ lẻ", "lẻ")
    s = s.capitalize + "đồng"
    # Trường hợp hiển thị đầy đủ không trăm đồng.
    #return s.sub("lẻ đồng", "đồng")
    # Trường hiển thị nghìn đồng
    return s.sub("không trăm lẻ đồng", "đồng")
  end

end
