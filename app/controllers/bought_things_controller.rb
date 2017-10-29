class BoughtThingsController < ApplicationController
  before_action :set_bought_thing, only: [:show, :update, :destroy]

  # GET /bought_things
  def index
    @bought_things = BoughtThing.all

    render json: @bought_things
  end

  # GET /bought_things/1
  def show
    render json: @bought_thing
  end

  # POST /bought_things
  def create
    @bought_thing = BoughtThing.new(bought_thing_params)

    if @bought_thing.save
      render json: @bought_thing, status: :created, location: @bought_thing
    else
      render json: @bought_thing.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /bought_things/1
  def update
    if @bought_thing.update(bought_thing_params)
      render json: @bought_thing
    else
      render json: @bought_thing.errors, status: :unprocessable_entity
    end
  end

  # DELETE /bought_things/1
  def destroy
    @bought_thing.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bought_thing
      @bought_thing = BoughtThing.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def bought_thing_params
      params.require(:bought_thing).permit(:thing_id, :user_id, :num)
    end
end
