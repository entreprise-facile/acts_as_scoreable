module ScoresHelper
  
  include ActionView::Helpers::JavaScriptHelper	
  include ActionView::Helpers::PrototypeHelper	
  def vote(entry)
    "<div class=\"vote\" id=\"vote-#{entry.id}\">
      <div id=\"uparrow-#{entry.id}\" class=\"up arrow\" onclick=\"#{ remote_function :url => url_for(:controller => :scores, :action => :voteup, :id => entry.id, :item => entry.class) }\"></div>
      <div id=\"count-#{entry.id}\" class=\"count\"><div>#{entry.score}</div></div>
      <div id=\"downarrow-#{entry.id}\" class=\"down arrow\" onclick=\"#{ remote_function :url => url_for(:controller => :scores, :action => :votedown, :id => entry.id, :item => entry.class) }\"></div>
      </div>"
  end
end