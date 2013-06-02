class AppKeysController < ApplicationController
  
  before_filter :authenticate_user!, :allowed?
  
  def create
    @app_key = AppKey.new(params[:app_key])
    @app_key.replace_blank_with_nil
    url = URI(@app_key.app_url)
    @app_key.entity_name = url.host
    if @app_key.save
      redirect_to user_path(current_user), flash: {notice: t("creation.success")}
    else
      @rss_appkeys = @user.app_keys
      @home = true
      @tags = @user.tags
      @without_tags = AppKey.without_tags(@user)
      @feed_entries = FeedEntry.where("app_key_id IN (?)", @user.app_keys.pluck("app_keys.id")).where("feed_entries.last_clicked_on is not null").page(params[:page]).per(50)
      render "users/show", flash: {error: t("creation.failure")}
    end
  end
  
  def destroy
    Delayed::Job.enqueue Dj3.new(params[:id])
    @app_key.update_attributes(is_pending: "to_delete")
    redirect_to user_path(current_user)
  end
    
  def request_fetch
    Delayed::Job.enqueue Dj1.new(self.id)
    redirect_to user_path(current_user), flash: {notice: "Pls. wait as we refresh."}
  end
  
  private
  
  def allowed?
    @user = current_user
    @app_key = AppKey.find(params[:id]) if !params[:id].blank?
    if @user.id != current_user.id
      redirect_to root_url, flash: {error: t("permission.denied")}
    end
  end
  
end