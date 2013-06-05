class AppKeysController < ApplicationController
  
  before_filter :authenticate_user!, :allowed?
  
  def create
    @app_key = AppKey.new(params[:app_key])
    @app_key.replace_blank_with_nil
    if @app_key.save
      redirect_to user_path(current_user), flash: {notice: t("creation.success")}
    else
      @rss_appkeys = @user.app_keys
      @home = true
      @tags = @user.tags
      @without_tags = AppKey.without_tags(@user)
      @feed_entries = FeedEntry.read.by_user(@user).page(params[:page]).per(50)
      render "users/show", flash: {error: t("creation.failure")}
    end
  end
  
  def destroy
    Delayed::Job.enqueue Dj3.new(params[:id])
    @app_key.update_attributes(is_pending: "to_delete")
    redirect_to user_path(current_user), flash: {notice: "Unsubscribing you."}
  end
    
  def request_fetch
    Delayed::Job.enqueue Dj1.new(params[:id], false)
    redirect_to user_path(current_user), flash: {notice: "Please wait while we refresh."}
  end
  
  private
  
  def allowed?
    @app_key = AppKey.find(params[:id]) if !params[:id].blank?
  end
  
end