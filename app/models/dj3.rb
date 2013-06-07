class Dj3 < Struct.new(:akid)
  
  #DELETE
  
  def perform
    app_key = AppKey.find(akid)
    if !app_key.blank?
      app_key.destroy
    end
  end
  
  #PRIVATE
  private
  
end