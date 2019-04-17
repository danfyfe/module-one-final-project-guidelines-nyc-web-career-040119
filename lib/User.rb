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

#   def user_stash_names
#     user_stash.each do |strain|
#     puts "#{strain.name}"
#   end
# end

  def check_stash
    # binding.pry

    user_stash = []
    self.stash.select do |stashette|
      user_stash << Strain.all.find_by_id(stashette.strain_id)
    end
    user_stash = user_stash.uniq!
    i = 0
    puts "Your stash cotains:"
    user_stash_names = user_stash.map do |strain|
      puts "#{i+1}. #{strain.name}"
      i += 1
    end



    # puts "Your stash contains: #{user_stash_names}"
    # puts "~" * 22

  end

  #   puts "Your stash contains:"
  #   user_stash = []
  #   self.stash.select do |stashette|
  #     user_stash << Strain.all.find_by_id(stashette.strain_id)
  #   end
  #   "#{user_stash}"
  # end

  def create_stash_instance(current_strain_id)
    Stash.create(user_id: self.id, strain_id: current_strain_id)
  end
end
