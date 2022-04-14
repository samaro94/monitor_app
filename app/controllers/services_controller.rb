class ServicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_service, only: %i[ show edit update destroy change_status ]
  include ActionView::Helpers::OutputSafetyHelper
  include Heroicon::Engine.helpers
  include ApplicationHelper

  # GET /services or /services.json
  def index
    @services = Service.all
    @services_path = services_path
  end

  # GET /services/1 or /services/1.json
  def show
  end

  # GET /services/new
  def new
    @service = Service.new
  end

  # GET /services/1/edit
  def edit
    @services_path = service_path(@service)
  end

  # POST /services or /services.json
  def create
    @service = Service.new(service_params)

    respond_to do |format|
      if @service.save
        format.html { redirect_to services_path, notice: "Service was successfully created." }
        format.json { render :show, status: :created, location: @service }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /services/1 or /services/1.json
  def update
    respond_to do |format|
      if @service.update(service_params)
        format.html { redirect_to services_path, notice: "Service was successfully updated." }
        format.json { render :show, status: :ok, location: @service }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  def get_list
    header = ["id", "name", "aasm_state", "details"]
    services = Service.all.select(header).order(id: :desc)
    services = services.search(params[:search]) if !params[:search].blank?
    columns = header.map{|x| I18n.t(x)}

    render json: { columns: columns, data: services, actions: get_actions }
  end

  def change_status
    begin
      if @service.aasm_state == "active"
        @service.deactivate!
      else
        @service.activate!
      end
      render json:{ message: "Ok", code: 200}, status: 200
    rescue
      render json:{ message: "Error", code: 500}, status: 500
    end

  end

  # DELETE /services/1 or /services/1.json
  def destroy
    @service.destroy

    respond_to do |format|
      format.html { redirect_to services_url, notice: "Service was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service
      @service = Service.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def service_params
      params.require(:service).permit(:name, :details)
    end

    def get_actions
      return [
        {label: I18n.t('edit'), icon: icon_tag("pencil"), type: "render", url: "/services/:id/edit", method: "delete", style: "without-label btn-primary secondary-color"},
        {label: I18n.t('change_status'), icon: icon_tag("switch-horizontal"), type: "request", url: "/services/:id/change_status", method: "get", style: "without-label btn-primary secondary-color"},
        {label: I18n.t('modify_turns'), icon: icon_tag("cog"), url: "/service_blocks/modify/:id", type: "render", method: "get", style: "without-label btn-primary secondary-color"},
        {label: I18n.t('show_service_availability'), icon: icon_tag("calendar"), url: "/shifts/service_availability?service_id=:id", type: "render", method: "get", style: "without-label btn-outline-primary"},
        {label: I18n.t('show_service_shifts'), icon: icon_tag("clipboard-list"), url: "/shifts/service_shifts?service_id=:id", type: "render", method: "get", style: "without-label btn-outline-primary"}
      ]
    end
end
