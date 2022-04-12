class ServiceBlocksController < ApplicationController
  # GET /service_blocks or /service_blocks.json
  def index
    @service_blocks = ServiceBlock.all
  end

  def modify
    @service = Service.find(params[:service_id])
  end

  private
  
end
