module ApplicationHelper
  def active_controller(controller_name)
    (params[:controller].eql? controller_name) ? 'active' : nil
  end

  def current_controller
    params[:controller].capitalize
  end

  def current_action
    params[:action].capitalize
  end

  def table_td(objects)
    return if objects.count.eql? 3
    if objects.count.eql? 1
      html = <<-HTML
        <td></td><td></td>
      HTML
    else
      html = <<-HTML
        <td></td>
      HTML
    end
    html.html_safe
  end
end
