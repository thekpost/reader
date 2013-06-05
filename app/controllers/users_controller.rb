class UsersController < ApplicationController
  
  before_filter :authenticate_user!
  
  def admin
    if !@user.is_admin?
      redirect_to user_path(current_user)
    end
    @users = User.all
    @total_subscriptions = AppKey.count
    @total_articles = FeedEntry.count
    @total_history = FeedEntry.read.count
    @total_star = FeedEntry.star.count
    @total_to_read = FeedEntry.to_read.count
    @response_obj = []
    @users.each do |u|
      @response_obj << [u, u.app_keys.count, u.feed_entries_count(nil, nil), u.feed_entries_count('h' , nil), u.feed_entries_count('s' , nil), u.feed_entries_count('r', nil)]
    end
  end
  
  def job
    if !@user.is_admin?
      redirect_to user_path(current_user)
    end
    @delayedjobs = DelayedJob.all
  end
  
  def show
    @tags = @user.tags
    @without_tags = AppKey.without_tags(@user)
    @app_key = AppKey.new
    @rss_appkeys = @user.app_keys
    @total_subscriptions = @user.feed_entries_count(nil, nil)
    @total_history = @user.feed_entries_count('h' , nil)
    @total_star = @user.feed_entries_count('s' , nil)
    @total_to_read = @user.feed_entries_count('r', nil)
        
    if !params[:entry].blank?
      @feed_article = FeedEntry.find(params[:entry])
      @feed_article.update_attributes(is_to_read: false, last_clicked_on: Time.now)
    end
    @is_star = params[:s]
    @history = params[:h]
    @to_read = params[:r]
    @akid = params[:akid]
    @home = (params[:r].blank? and params[:h].blank? and params[:s].blank? and params[:akid].blank?) ? true : false 
    if !params[:h].blank?
      @feed_entries = FeedEntry.read.by_user(@user).page(params[:page]).per(50)
    elsif !params[:r].blank?
      @feed_entries = FeedEntry.to_read.by_user(@user).page(params[:page]).per(50)
    elsif !params[:s].blank?
      @feed_entries = FeedEntry.star.by_user(@user).page(params[:page]).per(50)
    elsif !params[:akid].blank?
      @feed_entries = FeedEntry.where("feed_entries.app_key_id = ?", params[:akid]).page(params[:page]).per(50)
    else
      @feed_entries = FeedEntry.by_user(@user).page(params[:page]).per(50)
    end
  end
    
  def edit
    @menu = "set"
  end
  
  def update
    if @user.update_attributes(params[:user])
      redirect_to @user, flash: {notice: t("updation.success")}
    else
      render action: "edit" 
    end
    @menu = "set"
  end
  
end
