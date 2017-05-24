module Admin::RentersHelper
  def convert_sex(str)
      if str == 0
        "Nam"
      elsif str==1
        "Nữ"
      else
        ""
      end
  end

  def convert_career(str)
    if str!= nil
      if str == 1
        "Sinh viên"
      elsif str==2
        "Người đi làm"
      end
    end
  end

  def convert_temporary_registration(str)
      if str == 1
        "Đã đăng kí"
      elsif str==2
        "Chưa đăng kí"
      end
  end

  def convert_owner(str)
      if str == 0
        " "
      elsif str==1
        "Đại diện"
      end
  end

  def convert_available_status(str)
    if str == Admin::Constants::AVAILABLE_STATUS_NO
      "Không"
    elsif str == Admin::Constants::AVAILABLE_STATUS_YES
      "Đang ở"
    end
  end
end
