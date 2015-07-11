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
end
