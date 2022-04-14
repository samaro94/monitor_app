module ApplicationHelper
  def icon_tag(name, width = 20)
    return heroicon name, options: { width: width }
  end
end
