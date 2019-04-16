

def welcome
  puts "Welcome to Hempirical"
  puts "*" * 21
end

def get_user_input
  puts "Please enter user name"
  input = gets.chomp
end

def is_returning_user?(user_input)
  
  users = User.all.select do |user|
    user.name.downcase == user_input.downcase
  end

  if users.empty?
    User.create(name: user_input)
    puts "Welcome, #{user_input}!"
  else
    puts "Welcome back, #{user_input}!"
  end
end




