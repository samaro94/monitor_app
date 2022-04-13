class ShiftsController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery with: :null_session, only: :update

  def index

  end

  def get_list
    get_users
    get_service_hours
    @header = @users.decorate.map{|x| x.full_name}
    @data = ShiftDataService.get_data(params[:type], @users, @service_hours)

    render json: {header: [I18n.t('blocks')] + @header, data: @data}
  end

  def modify_all
    new_info = JSON.parse(request.body.read)
    saved = UpdateShiftService.update_all_users(new_info)

    if saved
      render json:{ message: "Ok", code: 200}, status: 200
    else
      render json:{ message: "Error", code: 500}, status: 500
    end
  end

  private

  def get_users
    @users = User.all
  end

  def get_service_hours
    @service_hours = (00..23).map{|x| "#{x}:00".to_time.strftime("%H:%M")}
  end

end
