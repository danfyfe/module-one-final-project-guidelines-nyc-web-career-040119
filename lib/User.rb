class User < ActiveRecord::Base

  has_many :strains, through: :stash

  def stash
    Stash.all.select do |stash|
      stash.user_id == self.id
    end
  end
  # def is_returning_user?(user_input)
  #
  #   users = User.all.select do |user|
  #     user.name.downcase == user_input.downcase
  #   end
  #
  #   if users.empty?
  #     User.create(name: user_input)
  #     puts "Welcome, #{user_input}!"
  #   else
  #     puts "Welcome back, #{user_input}!"
  #   end
  #   puts "*" * 21
  # end



  def check_stash
    puts "checking stash, brah"
    binding.pry

  end



end
