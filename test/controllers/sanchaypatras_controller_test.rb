require 'test_helper'

class SanchaypatrasControllerTest < ActionController::TestCase
  setup do
    @sanchaypatra = sanchaypatras(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sanchaypatras)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sanchaypatra" do
    assert_difference('Sanchaypatra.count') do
      post :create, sanchaypatra: { active_date: @sanchaypatra.active_date, amount: @sanchaypatra.amount, expire_date: @sanchaypatra.expire_date, issue_date: @sanchaypatra.issue_date, profilt_percentage: @sanchaypatra.profilt_percentage, profit_per_lac: @sanchaypatra.profit_per_lac, reg_number: @sanchaypatra.reg_number }
    end

    assert_redirected_to sanchaypatra_path(assigns(:sanchaypatra))
  end

  test "should show sanchaypatra" do
    get :show, id: @sanchaypatra
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sanchaypatra
    assert_response :success
  end

  test "should update sanchaypatra" do
    patch :update, id: @sanchaypatra, sanchaypatra: { active_date: @sanchaypatra.active_date, amount: @sanchaypatra.amount, expire_date: @sanchaypatra.expire_date, issue_date: @sanchaypatra.issue_date, profilt_percentage: @sanchaypatra.profilt_percentage, profit_per_lac: @sanchaypatra.profit_per_lac, reg_number: @sanchaypatra.reg_number }
    assert_redirected_to sanchaypatra_path(assigns(:sanchaypatra))
  end

  test "should destroy sanchaypatra" do
    assert_difference('Sanchaypatra.count', -1) do
      delete :destroy, id: @sanchaypatra
    end

    assert_redirected_to sanchaypatras_path
  end
end
