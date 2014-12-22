task :whenever => :environment do
  user = User.all
  user.each do |u|
    hours = (Time.now - u.last_sign_in_at)/1.hour
    if hours > 24
      u.authentication_token = nil
      u.save
    end
  end
end




