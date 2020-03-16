require 'test_helper'

class CityTempDatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @city_temp_date = city_temp_dates(:one)
  end

  test "should get index" do
    get city_temp_dates_url
    assert_response :success
  end

  test "should get new" do
    get new_city_temp_date_url
    assert_response :success
  end

  test "should create city_temp_date" do
    assert_difference('CityTempDate.count') do
      post city_temp_dates_url, params: { city_temp_date: { city_id: @city_temp_date.city_id, date: @city_temp_date.date, temp_id: @city_temp_date.temp_id } }
    end

    assert_redirected_to city_temp_date_url(CityTempDate.last)
  end

  test "should show city_temp_date" do
    get city_temp_date_url(@city_temp_date)
    assert_response :success
  end

  test "should get edit" do
    get edit_city_temp_date_url(@city_temp_date)
    assert_response :success
  end

  test "should update city_temp_date" do
    patch city_temp_date_url(@city_temp_date), params: { city_temp_date: { city_id: @city_temp_date.city_id, date: @city_temp_date.date, temp_id: @city_temp_date.temp_id } }
    assert_redirected_to city_temp_date_url(@city_temp_date)
  end

  test "should destroy city_temp_date" do
    assert_difference('CityTempDate.count', -1) do
      delete city_temp_date_url(@city_temp_date)
    end

    assert_redirected_to city_temp_dates_url
  end
end
