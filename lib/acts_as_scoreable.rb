# ActsAsScoreable
%w{ models helpers controllers }.each do |dir|
  path = File.join(File.dirname(__FILE__), 'app', dir)
  $LOAD_PATH << path
  ActiveSupport::Dependencies.load_paths << path
  ActiveSupport::Dependencies.load_once_paths.delete(path)
end

module ActsAsScoreable
  #we include our code to the rails app
  def self.included(base)
    base.send :extend, ClassMethods
  end
  
  module ClassMethods
    # any method placed here will apply to classes, like Hickwall
    def acts_as_scoreable(options = {})
      cattr_accessor :acts_as_scoreable_text_field
      self.acts_as_scoreable_text_field = (options[:acts_as_scoreable_text_field] || :score).to_s
      send :include, InstanceMethods
    end
  end
  
  module InstanceMethods
    # any method placed here will apply to instaces, like @hickwall
    def score=(integer)
      self.class.update_all("#{self.class.acts_as_scoreable_text_field} = #{integer}", "id = #{self.id}")
    end
    
    def score_up
      self.class.update_counters(self.id, self.class.acts_as_scoreable_text_field.to_sym => +1)
    end
    
    def score_down
      self.class.update_counters(self.id, self.class.acts_as_scoreable_text_field.to_sym => -1)
    end
  end
  
  
end

#we include InstanceMethods and ClassMethods
ActiveRecord::Base.send :include, ActsAsScoreable
#we include helpers
ActionView::Base.send :include, ScoresHelper
ActionController::Base.send :include, ScoresHelper