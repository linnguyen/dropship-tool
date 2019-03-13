require 'test_helper'

class EbayControllerTest < ActionDispatch::IntegrationTest
  test "should get get_product" do
    get ebay_get_product_url
    assert_response :success
  end

end
