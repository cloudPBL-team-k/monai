require 'test_helper'

class BoughtThingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bought_thing = bought_things(:one)
  end

  test "should get index" do
    get bought_things_url, as: :json
    assert_response :success
  end

  test "should create bought_thing" do
    assert_difference('BoughtThing.count') do
      post bought_things_url, params: { bought_thing: { num: @bought_thing.num, thing_id: @bought_thing.thing_id, user_id: @bought_thing.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show bought_thing" do
    get bought_thing_url(@bought_thing), as: :json
    assert_response :success
  end

  test "should update bought_thing" do
    patch bought_thing_url(@bought_thing), params: { bought_thing: { num: @bought_thing.num, thing_id: @bought_thing.thing_id, user_id: @bought_thing.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy bought_thing" do
    assert_difference('BoughtThing.count', -1) do
      delete bought_thing_url(@bought_thing), as: :json
    end

    assert_response 204
  end
end
