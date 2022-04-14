class ServiceBlocksController < ApplicationController
  before_action :authenticate_user!
  before_action :find_service
  protect_from_forgery with: :null_session, only: :update
  
  def index
    @service_blocks = ConfigurateBlocksService.get_blocks(@service.id)
    
    render json: @service_blocks
  end

  def modify
    @title = I18n.t('modify_service_blocks')
  end

  def update
    new_info = JSON.parse(request.body.read)
    saved = ConfigurateBlocksService.update_blocks(params[:service_id], new_info)

    if saved
      render json:{ message: "Ok", code: 200}, status: 200
    else
      render json:{ message: "Error", code: 500}, status: 500
    end
  end

  private

  def find_service
    @service = Service.find_by_id(params[:service_id])
  end

end
