require "application_system_test_case"

class ServiceBlocksTest < ApplicationSystemTestCase
  setup do
    @service_block = service_blocks(:one)
  end

  test "visiting the index" do
    visit service_blocks_url
    assert_selector "h1", text: "Service blocks"
  end

  test "should create service block" do
    visit service_blocks_url
    click_on "New service block"

    fill_in "Hour", with: @service_block.hour
    fill_in "Service", with: @service_block.service_id
    fill_in "Week day", with: @service_block.week_day
    click_on "Create Service block"

    assert_text "Service block was successfully created"
    click_on "Back"
  end

  test "should update Service block" do
    visit service_block_url(@service_block)
    click_on "Edit this service block", match: :first

    fill_in "Hour", with: @service_block.hour
    fill_in "Service", with: @service_block.service_id
    fill_in "Week day", with: @service_block.week_day
    click_on "Update Service block"

    assert_text "Service block was successfully updated"
    click_on "Back"
  end

  test "should destroy Service block" do
    visit service_block_url(@service_block)
    click_on "Destroy this service block", match: :first

    assert_text "Service block was successfully destroyed"
  end
end
