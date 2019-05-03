require "application_system_test_case"

class SpecialistsTest < ApplicationSystemTestCase
  setup do
    @specialist = specialists(:one)
  end

  test "visiting the index" do
    visit specialists_url
    assert_selector "h1", text: "Specialists"
  end

  test "creating a Specialist" do
    visit specialists_url
    click_on "New Specialist"

    fill_in "City", with: @specialist.city
    fill_in "Company name", with: @specialist.company_name
    fill_in "Coordx", with: @specialist.coordx
    fill_in "Coordy", with: @specialist.coordy
    fill_in "First name", with: @specialist.first_name
    fill_in "Last name", with: @specialist.last_name
    fill_in "Specialty", with: @specialist.specialty_id
    fill_in "Street", with: @specialist.street
    click_on "Create Specialist"

    assert_text "Specialist was successfully created"
    click_on "Back"
  end

  test "updating a Specialist" do
    visit specialists_url
    click_on "Edit", match: :first

    fill_in "City", with: @specialist.city
    fill_in "Company name", with: @specialist.company_name
    fill_in "Coordx", with: @specialist.coordx
    fill_in "Coordy", with: @specialist.coordy
    fill_in "First name", with: @specialist.first_name
    fill_in "Last name", with: @specialist.last_name
    fill_in "Specialty", with: @specialist.specialty_id
    fill_in "Street", with: @specialist.street
    click_on "Update Specialist"

    assert_text "Specialist was successfully updated"
    click_on "Back"
  end

  test "destroying a Specialist" do
    visit specialists_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Specialist was successfully destroyed"
  end
end
