class ThingCategoriesController < ApplicationController
  before_action :set_thing_category, only: [:show, :update, :destroy]

  # GET /thing_categories
  def index
    @thing_categories = ThingCategory.all

    render json: @thing_categories
  end

  # GET /thing_categories/1
  def show
    render json: @thing_category
  end

  # POST /thing_categories
  def create
    @thing_category = ThingCategory.new(thing_category_params)

    if @thing_category.save
      render json: @thing_category, status: :created, location: @thing_category
    else
      render json: @thing_category.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /thing_categories/1
  def update
    if @thing_category.update(thing_category_params)
      render json: @thing_category
    else
      render json: @thing_category.errors, status: :unprocessable_entity
    end
  end

  # DELETE /thing_categories/1
  def destroy
    @thing_category.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_thing_category
      @thing_category = ThingCategory.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def thing_category_params
      params.require(:thing_category).permit(:thing_id, :category_id)
    end
end
