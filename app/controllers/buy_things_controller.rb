class BuyThingsController < ApplicationController
  before_action :set_buy_thing, only: [:show, :update, :destroy]

  # GET /buy_things
  def index
    user_id = params[:user_id]
    
        if user_id == nil
          # user_idパラメータがからだったらHTTP Status400
          head 400
          return
        else
          # BuyThingテーブルからuser_idで絞り込んでとThingテーブルと内部結合(JOIN)
          # ThingテーブルのnameとBuyThingテーブルのすべての列を取得する
          @buy_things = BuyThing.where(user_id: user_id).joins(:thing).select("things.name,buy_things.*").all.to_a.map(&:serializable_hash)
          # ThingAliasテーブルからuser_idで絞り込んでthing_idとaliasだけ取得する
          @aliases = ThingAlias.where(user_id: user_id).select("thing_id","alias").all.to_a.map(&:serializable_hash)
    
          # @buy_things(user_idの人が買った商品のリスト)のそれぞれにaliasを組み込んでいく
          for exp in @buy_things do
            # @aliasリストの中から@buy_thingsのthing_idと一致するものを選んで@buy_thingsの要素に組み込んでいく
            ali = @aliases.select{|i| i["thing_id"]==exp["thing_id"]}[0]
            if ali.nil?
              exp["alias"] = ""
            else
              exp["alias"] = ali["alias"]
            end
          end
        end
    
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

  # GET /buy_things/exists_bought
  def exists_bought
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
