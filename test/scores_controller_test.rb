require File.dirname(__FILE__) + '/test_helper.rb'
require 'scores_controller'
require 'action_controller/test_process'

class ScoresController; def rescue_action(e) raise e end; end

class ScoresControllerTest < ActionController::TestCase
  def setup
    @controller = ScoresController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new

    ActionController::Routing::Routes.draw do |map|
      map.resources :scores
    end
  end

  def test_index
    get :index
    assert_response :success
  end
end