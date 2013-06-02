class Dj3 < Struct.new(:fhub)
  
  #DELETE
  
  def perform
    app_key = AppKey.find(fhub)
    if !app_key.blank?
      app_key.destroy
    end
  end
  
  #PRIVATE
  private
  
end