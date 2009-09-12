class ScoresController < ActionController::Base
  
  def index
    render :text => "prout"
  end
  
  def voteup
    session[:voted_up].nil? ? session[:voted_up]=Hash.new : ''
    session[:voted_up]["#{params[:item]}"].nil? ? session[:voted_up]["#{params[:item]}"]=Hash.new : ''
    session[:voted_up]["#{params[:item]}"][params[:id].to_i].nil? ? session[:voted_up]["#{params[:item]}"][params[:id].to_i] = 0 : ''
    session[:voted_down].nil? ? session[:voted_down]=Hash.new : ''
    session[:voted_down]["#{params[:item]}"].nil? ? session[:voted_down]["#{params[:item]}"]=Hash.new : ''
    session[:voted_down]["#{params[:item]}"][params[:id].to_i].nil? ? session[:voted_down]["#{params[:item]}"][params[:id].to_i] = 0 : ''
    if (request.xhr?)
      if session[:voted_up]["#{params[:item]}"][params[:id].to_i] == 0
        if session[:voted_down]["#{params[:item]}"][params[:id].to_i] == 1
          @entry = eval(params[:item]).find(params[:id])
          @entry.score_up
          @entry.score_up
          session[:voted_up]["#{params[:item]}"][params[:id].to_i] = 1
          session[:voted_down]["#{params[:item]}"][params[:id].to_i] = 0
          render :update do |page|
            page.replace_html "dislike-#{params[:id]}", "-&nbsp;" + vote_down_link(@entry)
            page.replace_html "like-#{params[:id]}", "&nbsp;-&nbsp;" + vote_up_link_gray(@entry) + "&nbsp;"
            page.replace_html "count-#{params[:id]}", (@entry.score+2).to_s
          end
        else
          @entry = eval(params[:item]).find(params[:id])
          @entry.score_up
          session[:voted_up]["#{params[:item]}"][params[:id].to_i] = 1
          session[:voted_down]["#{params[:item]}"][params[:id].to_i] = 0
          render :update do |page|
            page.replace_html "like-#{params[:id]}", "&nbsp;-&nbsp;" + vote_up_link_gray(@entry) + "&nbsp;"
            page.replace_html "count-#{params[:id]}", (@entry.score+1).to_s
          end
        end
      else
        @entry = eval(params[:item]).find(params[:id])
        @entry.score_down
        session[:voted_up]["#{params[:item]}"][params[:id].to_i] = 0
        session[:voted_down]["#{params[:item]}"][params[:id].to_i] = 0
        render :update do |page|
          page.replace_html "like-#{params[:id]}", "&nbsp;-&nbsp;" + vote_up_link(@entry) + "&nbsp;"
          page.replace_html "count-#{params[:id]}", (@entry.score-1).to_s
        end
      end
    else
      render :text => '', :layout => false
    end
  end

  def votedown
    session[:voted_up].nil? ? session[:voted_up]=Hash.new : ''
    session[:voted_up]["#{params[:item]}"].nil? ? session[:voted_up]["#{params[:item]}"]=Hash.new : ''
    session[:voted_up]["#{params[:item]}"][params[:id].to_i].nil? ? session[:voted_up]["#{params[:item]}"][params[:id].to_i] = 0 : ''
    session[:voted_down].nil? ? session[:voted_down]=Hash.new : ''
    session[:voted_down]["#{params[:item]}"].nil? ? session[:voted_down]["#{params[:item]}"]=Hash.new : ''
    session[:voted_down]["#{params[:item]}"][params[:id].to_i].nil? ? session[:voted_down]["#{params[:item]}"][params[:id].to_i] = 0 : ''
    if (request.xhr?)
      if session[:voted_down]["#{params[:item]}"][params[:id].to_i] == 0
        if  session[:voted_up]["#{params[:item]}"][params[:id].to_i] == 1
          @entry = eval(params[:item]).find(params[:id])
          @entry.score_down
          @entry.score_down
          session[:voted_up]["#{params[:item]}"][params[:id].to_i] = 0
          session[:voted_down]["#{params[:item]}"][params[:id].to_i] = 1
          render :update do |page|
            page.replace_html "like-#{params[:id]}", "&nbsp;-&nbsp;" + vote_up_link(@entry) + "&nbsp;"
            page.replace_html "dislike-#{params[:id]}", "-&nbsp;" + vote_down_link_gray(@entry)
            page.replace_html "count-#{params[:id]}", (@entry.score-2).to_s
          end
        else
          @entry = eval(params[:item]).find(params[:id])
          @entry.score_down
          session[:voted_up]["#{params[:item]}"][params[:id].to_i] = 0
          session[:voted_down]["#{params[:item]}"][params[:id].to_i] = 1
          render :update do |page|
            page.replace_html "dislike-#{params[:id]}", "-&nbsp;" + vote_down_link_gray(@entry)
            page.replace_html "count-#{params[:id]}", (@entry.score-1).to_s
          end
        end
      else
        @entry = eval(params[:item]).find(params[:id])
        @entry.score_up
        session[:voted_up]["#{params[:item]}"][params[:id].to_i] = 0
        session[:voted_down]["#{params[:item]}"][params[:id].to_i] = 0
        render :update do |page|
          page.replace_html "dislike-#{params[:id]}", "-&nbsp;" + vote_down_link(@entry)
          page.replace_html "count-#{params[:id]}", (@entry.score+1).to_s
        end
      end
    else
      render :text => '', :layout => false
    end
  end


end