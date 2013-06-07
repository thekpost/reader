class FeedEntriesController < ApplicationController
  
  before_filter :authenticate_user!, :allowed?
  
  def update_star
    if @feed_article.present?
      current_star_index = FeedEntry::STARS.index(@feed_article.current_star)
      if @feed_article.last_starred_at.blank?
        new_star_index = (current_star_index + 1) % 13 # We have total 13 star images
      elsif (Time.now - @feed_article.last_starred_at).to_i > 5 
        new_star_index = 0
      else 
        new_star_index = (current_star_index + 1) % 13 # We have total 13 star images
      end
      @feed_article.update_attributes(current_star: FeedEntry::STARS[new_star_index], last_starred_at: Time.now, is_star: (new_star_index != 0))
    end
  end

  def mark_to_read
    if @feed_article.present?
      @feed_article.update_attributes(is_to_read: params[:is_to_read])
    end
  end

  def update
    if !params[:is_star].blank?
      @feed_article.update_attributes(is_star: params[:is_star])
    elsif !params[:is_to_read].blank?
      @feed_article.update_attributes(is_to_read: params[:is_to_read])
    end
    redirect_to :back
  end

  def show
    @feed_article.update_attributes(is_to_read: false, last_clicked_on: Time.now)
    redirect_to @feed_article.url
  end
  

  private
  
  def allowed?
    @feed_article = FeedEntry.find(params[:id])
  end
  
end
