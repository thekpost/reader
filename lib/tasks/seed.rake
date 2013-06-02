namespace :seed do
    
  #rake seed:db
  
  task :db => :environment do |t, args|
    
    puts "Seeding"
    u = User.new(email: "rp@pykih.com", password: "redfeed123", name: "Super Admin", username: "admin", slug: "admin", is_paying_customer: true)
    u.skip_confirmation!
    u.save

  end
  
end