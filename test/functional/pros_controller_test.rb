require 'test_helper'

class ProsControllerTest < ActionController::TestCase
  setup do
    @pro = pros(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pros)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pro" do
    assert_difference('Pro.count') do
      post :create, pro: { course_address: @pro.course_address, course_name: @pro.course_name, description: @pro.description, image_url: @pro.image_url, name: @pro.name, phone: @pro.phone }
    end

    assert_redirected_to pro_path(assigns(:pro))
  end

  test "should show pro" do
    get :show, id: @pro
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pro
    assert_response :success
  end

  test "should update pro" do
    put :update, id: @pro, pro: { course_address: @pro.course_address, course_name: @pro.course_name, description: @pro.description, image_url: @pro.image_url, name: @pro.name, phone: @pro.phone }
    assert_redirected_to pro_path(assigns(:pro))
  end

  test "should destroy pro" do
    assert_difference('Pro.count', -1) do
      delete :destroy, id: @pro
    end

    assert_redirected_to pros_path
  end
end
