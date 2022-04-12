class ServiceBlocksController < ApplicationController
  before_action :set_service_block, only: %i[ show edit update destroy ]

  # GET /service_blocks or /service_blocks.json
  def index
    @service_blocks = ServiceBlock.all
  end

  # GET /service_blocks/1 or /service_blocks/1.json
  def show
  end

  # GET /service_blocks/new
  def new
    @service_block = ServiceBlock.new
  end

  # GET /service_blocks/1/edit
  def edit
  end

  # POST /service_blocks or /service_blocks.json
  def create
    @service_block = ServiceBlock.new(service_block_params)

    respond_to do |format|
      if @service_block.save
        format.html { redirect_to service_block_url(@service_block), notice: "Service block was successfully created." }
        format.json { render :show, status: :created, location: @service_block }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @service_block.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /service_blocks/1 or /service_blocks/1.json
  def update
    respond_to do |format|
      if @service_block.update(service_block_params)
        format.html { redirect_to service_block_url(@service_block), notice: "Service block was successfully updated." }
        format.json { render :show, status: :ok, location: @service_block }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @service_block.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /service_blocks/1 or /service_blocks/1.json
  def destroy
    @service_block.destroy

    respond_to do |format|
      format.html { redirect_to service_blocks_url, notice: "Service block was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service_block
      @service_block = ServiceBlock.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def service_block_params
      params.require(:service_block).permit(:week_day, :hour, :service_id)
    end
end
