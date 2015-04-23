require 'test_helper'

class ActiclesControllerTest < ActionController::TestCase
  setup do
    @acticle = acticles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:acticles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create acticle" do
    assert_difference('Acticle.count') do
      post :create, acticle: { request_link: @acticle.request_link }
    end

    assert_redirected_to acticle_path(assigns(:acticle))
  end

  test "should show acticle" do
    get :show, id: @acticle
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @acticle
    assert_response :success
  end

  test "should update acticle" do
    patch :update, id: @acticle, acticle: { request_link: @acticle.request_link }
    assert_redirected_to acticle_path(assigns(:acticle))
  end

  test "should destroy acticle" do
    assert_difference('Acticle.count', -1) do
      delete :destroy, id: @acticle
    end

    assert_redirected_to acticles_path
  end
end
