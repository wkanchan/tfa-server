require 'test_helper'

class CorporatesControllerTest < ActionController::TestCase
  setup do
    @corporate = corporates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:corporates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create corporate" do
    assert_difference('Corporate.count') do
      post :create, corporate: { id: @corporate.id, key: @corporate.key, name: @corporate.name, status: @corporate.status }
    end

    assert_redirected_to corporate_path(assigns(:corporate))
  end

  test "should show corporate" do
    get :show, id: @corporate
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @corporate
    assert_response :success
  end

  test "should update corporate" do
    patch :update, id: @corporate, corporate: { id: @corporate.id, key: @corporate.key, name: @corporate.name, status: @corporate.status }
    assert_redirected_to corporate_path(assigns(:corporate))
  end

  test "should destroy corporate" do
    assert_difference('Corporate.count', -1) do
      delete :destroy, id: @corporate
    end

    assert_redirected_to corporates_path
  end
end
