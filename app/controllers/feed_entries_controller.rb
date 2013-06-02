class FeedEntriesController < ApplicationController
  
  before_filter :authenticate_user!, :allowed?
  
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
    @user = current_user
    if @user.id != current_user.id
      redirect_to root_url, flash: {error: t("permission.denied")}
    end
    @feed_article = FeedEntry.find(params[:id])
  end
  
end
