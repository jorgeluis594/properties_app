module ApplicationHelper
  def alert_class_for_type(type)
    case type
    when "error"
      "danger"
    else
      type
    end
  end
end
