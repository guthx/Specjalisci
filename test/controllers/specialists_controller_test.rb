require 'test_helper'

class SpecialistsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @specialist = specialists(:one)
  end

  test "should get index" do
    get specialists_url
    assert_response :success
  end

  test "should get new" do
    get new_specialist_url
    assert_response :success
  end

  test "should create specialist" do
    assert_difference('Specialist.count') do
      post specialists_url, params: { specialist: { city: @specialist.city, company_name: @specialist.company_name, coordx: @specialist.coordx, coordy: @specialist.coordy, first_name: @specialist.first_name, last_name: @specialist.last_name, specialty_id: @specialist.specialty_id, street: @specialist.street } }
    end

    assert_redirected_to specialist_url(Specialist.last)
  end

  test "should show specialist" do
    get specialist_url(@specialist)
    assert_response :success
  end

  test "should get edit" do
    get edit_specialist_url(@specialist)
    assert_response :success
  end

  test "should update specialist" do
    patch specialist_url(@specialist), params: { specialist: { city: @specialist.city, company_name: @specialist.company_name, coordx: @specialist.coordx, coordy: @specialist.coordy, first_name: @specialist.first_name, last_name: @specialist.last_name, specialty_id: @specialist.specialty_id, street: @specialist.street } }
    assert_redirected_to specialist_url(@specialist)
  end

  test "should destroy specialist" do
    assert_difference('Specialist.count', -1) do
      delete specialist_url(@specialist)
    end

    assert_redirected_to specialists_url
  end
end
