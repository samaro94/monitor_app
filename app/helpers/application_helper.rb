module ApplicationHelper
  def is_admin?
    controller.class.name.to_s.split("::").first == "Admin"
  end
end
