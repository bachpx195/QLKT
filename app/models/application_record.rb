class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  self.per_page = Admin::Constants::Paging::PER_PAGE

  def generate_code(type, id)
    case type
      when Admin::Constants::AutoGenerateCode::AGREEMENT
        return "#HĐG#{id.to_s.rjust(Admin::Constants::AutoGenerateCode::PADDING_LEFT, '0')}"
      when Admin::Constants::AutoGenerateCode::BILL
        return "#HĐN#{id.to_s.rjust(Admin::Constants::AutoGenerateCode::PADDING_LEFT, '0')}"
      when Admin::Constants::AutoGenerateCode::PAYMENT_BILL
        return "#PCH#{id.to_s.rjust(Admin::Constants::AutoGenerateCode::PADDING_LEFT, '0')}"
      when Admin::Constants::AutoGenerateCode::RENTER
        return "#KTH#{id.to_s.rjust(Admin::Constants::AutoGenerateCode::PADDING_LEFT, '0')}"
      else
        return ''
    end
  end
end
