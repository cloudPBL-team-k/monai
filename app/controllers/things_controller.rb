class ThingsController < ApplicationController
  before_action :set_thing, only: [:show, :update, :destroy]

  # GET /things
  def index
    @things = Thing.all

    render json: @things
  end

  # GET /things/1
  def show
    render json: @thing
  end

  # POST /things
  def create
    @thing = Thing.new(thing_params)

    if @thing.save
      render json: @thing, status: :created, location: @thing
    else
      render json: @thing.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /things/1
  def update
    if @thing.update(thing_params)
      render json: @thing
    else
      render json: @thing.errors, status: :unprocessable_entity
    end
  end

  # DELETE /things/1
  def destroy
    @thing.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_thing
      @thing = Thing.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def thing_params
      params.require(:thing).permit(:name, :jancode)
    end
end
