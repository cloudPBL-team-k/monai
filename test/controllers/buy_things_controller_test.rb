require 'test_helper'

class BuyThingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @buy_thing = buy_things(:one)
  end

  test "should get index" do
    get buy_things_url, as: :json
    assert_response :success
  end

  test "should create buy_thing" do
    assert_difference('BuyThing.count') do
      post buy_things_url, params: { buy_thing: { num: @buy_thing.num, thing_id: @buy_thing.thing_id, user_id: @buy_thing.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show buy_thing" do
    get buy_thing_url(@buy_thing), as: :json
    assert_response :success
  end

  test "should update buy_thing" do
    patch buy_thing_url(@buy_thing), params: { buy_thing: { num: @buy_thing.num, thing_id: @buy_thing.thing_id, user_id: @buy_thing.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy buy_thing" do
    assert_difference('BuyThing.count', -1) do
      delete buy_thing_url(@buy_thing), as: :json
    end

    assert_response 204
  end
end
