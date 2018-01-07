class ExpendablesController < ApplicationController
  before_action :set_expendable, only: [:show, :update, :destroy]

  # GET /expendables
  def index
    user_id = params[:user_id]
    if user_id == nil
      head 400
      return
    else
      @expendables = Expendable.joins(:thing).where(user_id: user_id).select("things.name,expendables.*").all.to_a.map(&:serializable_hash)
      @aliases = ThingAlias.where(user_id: user_id).select("thing_id","alias").all.to_a.map(&:serializable_hash)
      for exp in @expendables do
        ali = @aliases.select{|i| i["thing_id"]==exp["thing_id"]}[0]
        if ali.nil?
          exp["alias"] = ""
        else
          exp["alias"] = ali["alias"]
        end
      end
    end

    render json: @expendables
  end

  # GET /expendables/1
  def show
    render json: @expendable
  end

  # POST /expendables
  def create
    @expendable = Expendable.new(expendable_params)

    # aliasがあれば登録
    if params.has_key?(:alias)
      @ta = ThingAlias.where(user_id: params[:user_id]).where(thing_id: params[:thing_id])
      if @ta.exists?
        # alias更新
        @ta.update_all(alias: params[:alias], updated_at: Time.now)
      else
        # alias新規登録
        @ta = ThingAlias.new(user_id: params[:user_id], thing_id: params[:thing_id], alias: params[:alias])
        if !@ta.save
          render json: @ta.errors, status: :unprocessable_entity
        end
      end
    end

    if @expendable.save
      render json: @expendable, status: :created, location: @expendable
    else
      render json: @expendable.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /expendables/1
  def update
    if @expendable.update(expendable_params)
      render json: @expendable
    else
      render json: @expendable.errors, status: :unprocessable_entity
    end
  end

  # DELETE /expendables/1
  def destroy
    @expendable.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expendable
      @expendable = Expendable.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def expendable_params
      params.require(:expendable).permit(:thing_id, :user_id, :limit)
    end
end
