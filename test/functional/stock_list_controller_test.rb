require File.dirname(__FILE__) + '/../test_helper'
#require 'stock_list_controller'

# Re-raise errors caught by the controller.
#class StockListController; def rescue_action(e) raise e end; end

class StockListControllerTest < Test::Unit::TestCase
  def setup
    @controller = StockListController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_read_stock_list
#    @controller.index
  end
end
