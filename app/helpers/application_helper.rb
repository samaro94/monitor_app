module ApplicationHelper
  def is_admin?
    controller.class.name.to_s.split("::").first == "Admin"
  end

  def icon_tag(name)
    return heroicon name, options: { width: 20 }
  end
end
