require 'test_helper'

class ExpendablesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @expendable = expendables(:one)
  end

  test "should get index" do
    get expendables_url, as: :json
    assert_response :success
  end

  test "should create expendable" do
    assert_difference('Expendable.count') do
      post expendables_url, params: { expendable: { limit: @expendable.limit, thing_id: @expendable.thing_id, user_id: @expendable.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show expendable" do
    get expendable_url(@expendable), as: :json
    assert_response :success
  end

  test "should update expendable" do
    patch expendable_url(@expendable), params: { expendable: { limit: @expendable.limit, thing_id: @expendable.thing_id, user_id: @expendable.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy expendable" do
    assert_difference('Expendable.count', -1) do
      delete expendable_url(@expendable), as: :json
    end

    assert_response 204
  end
end
