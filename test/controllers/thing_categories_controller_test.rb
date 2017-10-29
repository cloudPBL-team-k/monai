require 'test_helper'

class ThingCategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @thing_category = thing_categories(:one)
  end

  test "should get index" do
    get thing_categories_url, as: :json
    assert_response :success
  end

  test "should create thing_category" do
    assert_difference('ThingCategory.count') do
      post thing_categories_url, params: { thing_category: { category_id: @thing_category.category_id, thing_id: @thing_category.thing_id } }, as: :json
    end

    assert_response 201
  end

  test "should show thing_category" do
    get thing_category_url(@thing_category), as: :json
    assert_response :success
  end

  test "should update thing_category" do
    patch thing_category_url(@thing_category), params: { thing_category: { category_id: @thing_category.category_id, thing_id: @thing_category.thing_id } }, as: :json
    assert_response 200
  end

  test "should destroy thing_category" do
    assert_difference('ThingCategory.count', -1) do
      delete thing_category_url(@thing_category), as: :json
    end

    assert_response 204
  end
end
