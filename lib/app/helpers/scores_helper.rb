module ScoresHelper
  
  include ActionView::Helpers::JavaScriptHelper	
  include ActionView::Helpers::PrototypeHelper	
  def vote(entry)
    "<div class=\"vote\" id=\"vote-#{entry.id}\">
    <div class=\"popularity\">Popularité&nbsp;:&nbsp;</div>
    <div id=\"count-#{entry.id}\" class=\"count\"><div>#{entry.score}</div></div>
    <div id=\"like-#{entry.id}\" class=\"likeclick\"><div>&nbsp;-&nbsp;#{vote_up_link(entry, "J'aime")}</div></div>
    <div id=\"dislike-#{entry.id}\" class=\"dislike\"><div>&nbsp;-&nbsp;#{vote_down_link(entry, "J'aime pas")}</div></div>
    </div>"
  end
  
  def vote_up_link(entry, text = "J'aime")
    link_to_remote text, :url => url_for(:controller => :scores, :action => :voteup, :id => entry.id, :item => entry.class)
  end
  
  def vote_down_link(entry, text = "J'aime pas")
    link_to_remote text, :url => url_for(:controller => :scores, :action => :votedown, :id => entry.id, :item => entry.class)
  end
  
  def vote_up_link_gray(entry, text = "J'aime")
    "<span class=\"undolike\" onclick=\"#{remote_function :url => url_for(:controller => :scores, :action => :voteup, :id => entry.id, :item => entry.class) }\">#{text}</span>"
  end
  
  def vote_down_link_gray(entry, text = "J'aime pas")
    "<span class=\"undolike\" onclick=\"#{remote_function :url => url_for(:controller => :scores, :action => :votedown, :id => entry.id, :item => entry.class) }\">#{text}</span>"
  end
  
  def count(entry)
    "#{entry.score}"
  end
  
end