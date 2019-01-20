# frozen_string_literal: true

class AdminConstraint
  def matches?(request)
    return false unless request.session.key?(:admin_id)

    admin = Admin.find_by(id: request.session.fetch(:admin_id))
    admin.present?
  end
end
