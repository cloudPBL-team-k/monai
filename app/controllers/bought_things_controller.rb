class BoughtThingsController < ApplicationController
  before_action :set_bought_thing, only: [:show, :update, :destroy]

  # GET /bought_things
  def index
    user_id = params[:user_id]
    if user_id.nil?
      head 400
    else
      @bought_things = BoughtThing.joins(:thing).where(user_id: user_id).select("bought_things.*,things.name").all.to_a.map(&:serializable_hash)
      @aliases = ThingAlias.where(user_id: user_id).select("thing_id","alias").all.to_a.map(&:serializable_hash)
      for bt in @bought_things do
        ali = @aliases.select{|i| i["thing_id"]==bt["thing_id"]}[0]
        if ali.nil?
          bt["alias"] = ""
        else
          bt["alias"] = ali["alias"]
        end
      end
      render json: @bought_things
    end
  end

  # GET /bought_things/1
  def show
    render json: @bought_thing
  end

  # POST /bought_things
  def create
    @bought_thing = BoughtThing.new(bought_thing_params)

    if @bought_thing.save
      # ここで過去の購入記録を参照し初回購入かどうか見て、初回であれば1990-01-01にセット、そうでなければ過去の購入間隔の平均値をセットする
      before_bought_things = BoughtThing.where(user_id: params[:user_id]).where(thing_id: params[:thing_id]).all
      if before_bought_things.size > 1 
        buy_interval = Array.new
        for i in 0..before_bought_things.size - 2
           b1 = Date.new(before_bought_things[i+1].created_at.year, before_bought_things[i+1].created_at.month, before_bought_things[i+1].created_at.day)
           b2 = Date.new(before_bought_things[i].created_at.year, before_bought_things[i].created_at.month, before_bought_things[i].created_at.day)
           interval = b1 - b2 # ここ有理数で帰ってくる
           if interval == 0
             next
           end
           puts(interval)
           if interval > 0
            buy_interval.push(interval)
           end
        end
        if buy_interval.sum == 0 || buy_interval.size == 0
          b = Date.new(before_bought_things[0].created_at.year, before_bought_things[0].created_at.month, before_bought_things[0].created_at.day)
          next_buy_date = Date.today + (Date.today - b)
        else
          interval_average = buy_interval.sum / buy_interval.size
          next_buy_date = Date.today + interval_average
        end
      else
        next_buy_date = Date.new(1990, 1, 1)
      end
      render json: {'next_buy_date': next_buy_date}, status: :created, location: @bought_thing
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
