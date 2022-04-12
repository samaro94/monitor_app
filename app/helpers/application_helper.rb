module ApplicationHelper
  def icon_tag(name)
    return heroicon name, options: { width: 20 }
  end
end
