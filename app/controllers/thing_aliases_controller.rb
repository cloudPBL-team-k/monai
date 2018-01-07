class ThingAliasesController < ApplicationController

  # GET /thing_alias
  def index
    @thing_aliases = ThingAlias.all

    render json: @thing_aliases
  end

  # POST /thing_alias
  def create
    @thing_aliases = ThingAlias.new(thing_aliases_params)

    if @thing_aliases.save
      render json: @thing_aliases, status: :created
    else
      render json: @thing_aliases.errors, status: :unprocessable_entity
    end
  end

  private
    def thing_aliases_params
      params.require(:thing_alias).permit(:thing_id, :user_id, :alias)
    end
end
