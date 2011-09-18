require File.dirname(__FILE__) + '/../test_helper'
require 'stockwatch_controller'

# Re-raise errors caught by the controller.
class StockwatchController; def rescue_action(e) raise e end; end

class StockwatchControllerTest < Test::Unit::TestCase
  def setup
    @controller = StockwatchController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_index
    post :index
    @sectors = assigns(:sectors)
    assert 1, @sectors.size
    assert @sectors[0].companies[0].is_marked(:eps)
  end
end
