require 'test_helper'

class TrophiesControllerTest < ActionController::TestCase
  setup do
    @trophy = trophies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:trophies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create trophy" do
    assert_difference('Trophy.count') do
      post :create, trophy: {  }
    end

    assert_redirected_to trophy_path(assigns(:trophy))
  end

  test "should show trophy" do
    get :show, id: @trophy
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @trophy
    assert_response :success
  end

  test "should update trophy" do
    patch :update, id: @trophy, trophy: {  }
    assert_redirected_to trophy_path(assigns(:trophy))
  end

  test "should destroy trophy" do
    assert_difference('Trophy.count', -1) do
      delete :destroy, id: @trophy
    end

    assert_redirected_to trophies_path
  end
end
