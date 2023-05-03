module ApplicationHelper
  def alert_class_for_type(type)
    case type
    when "error"
      "danger"
    else
      type
    end
  end

  def render_pagination(current_page, pages)
    render partial: 'partials/pagination', locals: { current_page: current_page, pages: pages }
  end

  def url_page_for(page)
    url = request.fullpath.gsub(/[?|&|\/]page[=|\/]\d+/,'')
    [url, "page=#{page}"].join(url['?'] ? '&' : '?')
  end
end
