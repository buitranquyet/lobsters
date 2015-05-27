user = User.create(:username => "musklevel", :email => "musklevel@musklevel.com", :password => "test", :password_confirmation => "test", :is_admin => true, :is_moderator => true)
puts "created user: musklevel, password: test"
tag = Tag.create(:tag => "idea")
puts "created tag: idea"
