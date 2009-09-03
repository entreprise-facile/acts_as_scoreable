# Include hook code here
class << ActionController::Routing::Routes;self;end.class_eval do
  define_method :clear!, lambda {}
end

ActionController::Routing::Routes.draw do |map|
  map.connect '/scores/:action/:id', :controller => 'scores'
end

require 'acts_as_scoreable'