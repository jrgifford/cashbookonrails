require File.dirname(__FILE__) + '/../test_helper'

class PayeesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:payees)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_payee
    assert_difference('Payee.count') do
      post :create, :payee => { }
    end

    assert_redirected_to payee_path(assigns(:payee))
  end

  def test_should_show_payee
    get :show, :id => payees(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => payees(:one).id
    assert_response :success
  end

  def test_should_update_payee
    put :update, :id => payees(:one).id, :payee => { }
    assert_redirected_to payee_path(assigns(:payee))
  end

  def test_should_destroy_payee
    assert_difference('Payee.count', -1) do
      delete :destroy, :id => payees(:one).id
    end

    assert_redirected_to payees_path
  end
end
