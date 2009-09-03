require File.dirname(__FILE__) + '/test_helper.rb'


class Entry < ActiveRecord::Base
  acts_as_scoreable
end

class Event < ActiveRecord::Base
  acts_as_scoreable :acts_as_scoreable_text_field => :points
end

class ActsAsScoreableTest < Test::Unit::TestCase
  
  #we load our db schema
  load_schema
  
  def test_schema_has_loaded_correctly
    assert_equal [], Entry.all
    assert_equal [], Event.all
  end
  
  def test_an_entry_acts_as_scoreable_text_field_should_be_score
    assert_equal "score", Entry.acts_as_scoreable_text_field
  end
  
  def test_an_event_acts_as_scoreable_text_field_should_be_points
    assert_equal "points", Event.acts_as_scoreable_text_field
  end
  
  def test_entry_score_up_should_score_up
    entry = Entry.new
    entry.score_up
    assert_equal 1, entry.score
  end
  
  def test_entry_score_down_should_score_down
    entry = Entry.new
    entry.score_down
    assert_equal -1, entry.score
  end
  
  def test_entry_score_equal_should_define_a_score
    entry = Entry.new
    entry.score=4
    assert_equal 4, entry.score
  end
  
  def test_event_score_up_should_score_up
    event = Event.new
    event.score_up
    assert_equal 1, event.points
  end
  
  def test_event_score_down_should_score_down
    event = Event.new
    event.score_down
    assert_equal -1, event.points
  end
  
  def test_event_score_equal_should_define_a_score
    event = Event.new
    event.score=4
    assert_equal 4, event.points
  end
  





end