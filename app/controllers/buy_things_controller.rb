class BuyThingsController < ApplicationController
  before_action :set_buy_thing, only: [:show, :update, :destroy]

  # GET /buy_things
  def index
    @buy_things = BuyThing.all

    render json: @buy_things
  end

  # GET /buy_things/1
  def show
    render json: @buy_thing
  end

  # POST /buy_things
  def create
    @buy_thing = BuyThing.new(buy_thing_params)

    if @buy_thing.save
      render json: @buy_thing, status: :created, location: @buy_thing
    else
      render json: @buy_thing.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /buy_things/1
  def update
    if @buy_thing.update(buy_thing_params)
      render json: @buy_thing
    else
      render json: @buy_thing.errors, status: :unprocessable_entity
    end
  end

  # DELETE /buy_things/1
  def destroy
    @buy_thing.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_buy_thing
      @buy_thing = BuyThing.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def buy_thing_params
      params.require(:buy_thing).permit(:thing_id, :user_id, :num)
    end
end
