require 'test_helper'

class TempsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @temp = temps(:one)
  end

  test "should get index" do
    get temps_url
    assert_response :success
  end

  test "should get new" do
    get new_temp_url
    assert_response :success
  end

  test "should create temp" do
    assert_difference('Temp.count') do
      post temps_url, params: { temp: { city_id: @temp.city_id, date: @temp.date, temp_high: @temp.temp_high, temp_low: @temp.temp_low, temp_mid: @temp.temp_mid } }
    end

    assert_redirected_to temp_url(Temp.last)
  end

  test "should show temp" do
    get temp_url(@temp)
    assert_response :success
  end

  test "should get edit" do
    get edit_temp_url(@temp)
    assert_response :success
  end

  test "should update temp" do
    patch temp_url(@temp), params: { temp: { city_id: @temp.city_id, date: @temp.date, temp_high: @temp.temp_high, temp_low: @temp.temp_low, temp_mid: @temp.temp_mid } }
    assert_redirected_to temp_url(@temp)
  end

  test "should destroy temp" do
    assert_difference('Temp.count', -1) do
      delete temp_url(@temp)
    end

    assert_redirected_to temps_url
  end
end
