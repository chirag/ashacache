require File.dirname(__FILE__) + '/../test_helper'

class DocumentationsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:documentations)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_documentation
    assert_difference('Documentation.count') do
      post :create, :documentation => { }
    end

    assert_redirected_to documentation_path(assigns(:documentation))
  end

  def test_should_show_documentation
    get :show, :id => documentations(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => documentations(:one).id
    assert_response :success
  end

  def test_should_update_documentation
    put :update, :id => documentations(:one).id, :documentation => { }
    assert_redirected_to documentation_path(assigns(:documentation))
  end

  def test_should_destroy_documentation
    assert_difference('Documentation.count', -1) do
      delete :destroy, :id => documentations(:one).id
    end

    assert_redirected_to documentations_path
  end
end
