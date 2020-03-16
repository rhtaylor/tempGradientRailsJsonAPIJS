require "application_system_test_case"

class CityTempDatesTest < ApplicationSystemTestCase
  setup do
    @city_temp_date = city_temp_dates(:one)
  end

  test "visiting the index" do
    visit city_temp_dates_url
    assert_selector "h1", text: "City Temp Dates"
  end

  test "creating a City temp date" do
    visit city_temp_dates_url
    click_on "New City Temp Date"

    fill_in "City", with: @city_temp_date.city_id
    fill_in "Date", with: @city_temp_date.date
    fill_in "Temp", with: @city_temp_date.temp_id
    click_on "Create City temp date"

    assert_text "City temp date was successfully created"
    click_on "Back"
  end

  test "updating a City temp date" do
    visit city_temp_dates_url
    click_on "Edit", match: :first

    fill_in "City", with: @city_temp_date.city_id
    fill_in "Date", with: @city_temp_date.date
    fill_in "Temp", with: @city_temp_date.temp_id
    click_on "Update City temp date"

    assert_text "City temp date was successfully updated"
    click_on "Back"
  end

  test "destroying a City temp date" do
    visit city_temp_dates_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "City temp date was successfully destroyed"
  end
end
