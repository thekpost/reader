namespace :conversion do
  
  task :do => :environment do |t, args|
    AppKey.all.each do |a|
      flag = false
      if !a.fav.blank?
        begin
          a = Nestful.get a.fav
          flag = true
        rescue
          flag = false
        end
      end
      a.update_attributes(favicon: flag ? a.fav : nil)
    end
  end
  
end