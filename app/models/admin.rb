module Admin

  module Constants

    #CONFIG KEYS
    CONFIG_TEN = 'TEN'
    CONFIG_DIACHI = 'DIACHI'
    CONFIG_DIENTHOAI = 'DIENTHOAI'
    CONFIG_GHICHUHOADON = 'GHICHUHOADON'
    CONFIG_CHUTRO = 'CHUTRO'
    CONFIG_TIEUDEHOADON = 'TIEUDEHOADON'
    CONFIG_TINHTHANH = 'TINHTHANH'
    CONFIG_CHUCNANGCOPY = 'CHUCNANGCOPY'

    NEW = 1
    EDIT = 2
    SEARCH = 3
    EXCEL = 4
    PDF = 5
    PRINT = 6
    AJAXFORM = 7
    FILTER = 8
    DETAIL = 9
    DEVICES = 10
    RENTER_ROOM = 11

    AGREEMENT_STATUS_VALID = 1
    AGREEMENT_STATUS_INVALID = 2

    AGREEMENT_SERVICE_STATUS_DEACTIVE = 1

    ROOM_EMPTY = 0
    ROOM_RENTED = 1
    ROOM_DEPOSITED = 2
    ROOM_RENTED_DEPOSITED = 3

    RENTER_SEX_UNKNOW = 2
    RENTER_OWNER_NOT = 0
    RENTER_TEMPORARY_REGISTRATION_NOT = 2

    BILL_PAID = 1
    BILL_NOT_PAID = 0

    SERVICE_ROOM= "SERVICE_ROOM"
    SERVICE_ELECTRICITY= "SERVICE_ELECTRICITY"
    SERVICE_WATER= "SERVICE_WATER"
    SERVICE_WATER_BY_PERSON= "SERVICE_WATER_BY_PERSON"

    AVAILABLE_STATUS_NO = 0
    AVAILABLE_STATUS_YES = 1

    AGREEMENT_ROOM = "AGREEMENT_ROOM"

    module PaymentType
      NONE = -1

      MONTH_DAILY = 0
      MONTH_DAILY_STR = "Chi trả hằng tháng"

      REPLACEMENT = 1
      REPLACEMENT_STR = "Chi phí sửa chữa"

      NEW = 2
      NEW_STR = "Mua sắm mới"

      OTHER = 3
      OTHER_STR = "Khác"
    end

    module Paging
      PER_PAGE = 25
    end

    module AutoGenerateCode
      AGREEMENT = 0
      BILL = 1
      PAYMENT_BILL = 2
      RENTER = 3

      PADDING_LEFT = 10
    end

    #Thinhlv room
    module RoomType
      SIMPLE = 0
      MULTY = 1
    end

    module SERVICES
      CODE_NORMAL = '1'
      CODE_ROOM = '1'
      CODE_ELECTRICITY = '2'
      CODE_WATER = '3'
      CODE_WATER_PER_PERSON = '4'

      NAME_ROOM = 'Tiền nhà'
      NAME_ELECTRICITY = 'Điện'
      NAME_WATER = 'Nước'

      UNIT_ROOM = 'VNĐ/Phòng'
      UNIT_ELECTRICITY = 'Kw/h'
      UNIT_WATER = 'Khối'
      UNIT_WATER_PER_PERSON = 'VNĐ/Người'

      UNIT_PRICE_ELECTRICITY = '3000'
      UNIT_PRICE_WATER = '6000'
      UNIT_PRICE_WATER_PER_PERSON = '50000'

      TYPE_FIX = 1
      TYPE_DYNAMIC = 0
    end

  end

  module ScreenName
    Dashboard = 0
    Agreement = 1
    ElectricityWater = 2
    Bill = 3
    PaymentBill = 4
    Building = 5
    Room = 6
    Renter = 7
    Service = 8
    Config = 9
    Feedback = 10
    Function = 11
    RoomDevice = 12
    Group = 13
    RoomStatistic = 14
    Report = 15
    ConfigCategory = 16
  end

end
