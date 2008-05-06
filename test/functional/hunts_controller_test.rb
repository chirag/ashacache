require File.dirname(__FILE__) + '/../test_helper'

class HuntsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:hunts)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_hunt
    assert_difference('Hunt.count') do
      post :create, :hunt => { }
    end

    assert_redirected_to hunt_path(assigns(:hunt))
  end

  def test_should_show_hunt
    get :show, :id => hunts(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => hunts(:one).id
    assert_response :success
  end

  def test_should_update_hunt
    put :update, :id => hunts(:one).id, :hunt => { }
    assert_redirected_to hunt_path(assigns(:hunt))
  end

  def test_should_destroy_hunt
    assert_difference('Hunt.count', -1) do
      delete :destroy, :id => hunts(:one).id
    end

    assert_redirected_to hunts_path
  end
end
