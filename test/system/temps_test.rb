require "application_system_test_case"

class TempsTest < ApplicationSystemTestCase
  setup do
    @temp = temps(:one)
  end

  test "visiting the index" do
    visit temps_url
    assert_selector "h1", text: "Temps"
  end

  test "creating a Temp" do
    visit temps_url
    click_on "New Temp"

    fill_in "High", with: @temp.high
    fill_in "Low", with: @temp.low
    fill_in "Med", with: @temp.med
    click_on "Create Temp"

    assert_text "Temp was successfully created"
    click_on "Back"
  end

  test "updating a Temp" do
    visit temps_url
    click_on "Edit", match: :first

    fill_in "High", with: @temp.high
    fill_in "Low", with: @temp.low
    fill_in "Med", with: @temp.med
    click_on "Update Temp"

    assert_text "Temp was successfully updated"
    click_on "Back"
  end

  test "destroying a Temp" do
    visit temps_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Temp was successfully destroyed"
  end
end
