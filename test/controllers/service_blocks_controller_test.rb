require "test_helper"

class ServiceBlocksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @service_block = service_blocks(:one)
  end

  test "should get index" do
    get service_blocks_url
    assert_response :success
  end

  test "should get new" do
    get new_service_block_url
    assert_response :success
  end

  test "should create service_block" do
    assert_difference("ServiceBlock.count") do
      post service_blocks_url, params: { service_block: { hour: @service_block.hour, service_id: @service_block.service_id, week_day: @service_block.week_day } }
    end

    assert_redirected_to service_block_url(ServiceBlock.last)
  end

  test "should show service_block" do
    get service_block_url(@service_block)
    assert_response :success
  end

  test "should get edit" do
    get edit_service_block_url(@service_block)
    assert_response :success
  end

  test "should update service_block" do
    patch service_block_url(@service_block), params: { service_block: { hour: @service_block.hour, service_id: @service_block.service_id, week_day: @service_block.week_day } }
    assert_redirected_to service_block_url(@service_block)
  end

  test "should destroy service_block" do
    assert_difference("ServiceBlock.count", -1) do
      delete service_block_url(@service_block)
    end

    assert_redirected_to service_blocks_url
  end
end
