class UserDecorator < ApplicationDecorator
  delegate_all

  def full_name
    "#{model.name} #{model.lastname}"
  end

end
