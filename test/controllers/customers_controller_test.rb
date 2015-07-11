require 'test_helper'

class CustomersControllerTest < ActionController::TestCase
  setup do
    @customer = customers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:customers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create customer" do
    assert_difference('Customer.count') do
      post :create, customer: { city: @customer.city, contact_no: @customer.contact_no, country: @customer.country, default: @customer.default, email: @customer.email, false: @customer.false, is_deleted: @customer.is_deleted, is_disabled: @customer.is_disabled, logo: @customer.logo, name: @customer.name, pincode: @customer.pincode, state: @customer.state, street: @customer.street }
    end

    assert_redirected_to customer_path(assigns(:customer))
  end

  test "should show customer" do
    get :show, id: @customer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @customer
    assert_response :success
  end

  test "should update customer" do
    patch :update, id: @customer, customer: { city: @customer.city, contact_no: @customer.contact_no, country: @customer.country, default: @customer.default, email: @customer.email, false: @customer.false, is_deleted: @customer.is_deleted, is_disabled: @customer.is_disabled, logo: @customer.logo, name: @customer.name, pincode: @customer.pincode, state: @customer.state, street: @customer.street }
    assert_redirected_to customer_path(assigns(:customer))
  end

  test "should destroy customer" do
    assert_difference('Customer.count', -1) do
      delete :destroy, id: @customer
    end

    assert_redirected_to customers_path
  end
end
