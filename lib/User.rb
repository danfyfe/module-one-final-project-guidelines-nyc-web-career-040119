class User < ActiveRecord::Base

  has_many :strains, through: :stash

  def stash
    Stash.all.select do |stash|
      stash.user_id == self.id
    end
  end

  def check_stash
    user_stash = []
    self.stash.select do |stashette|
      user_stash << Strain.all.find_by_id(stashette.strain_id)
    end
    if user_stash.empty?
      puts "Your stash is currently empty"
      puts ":" * 22
  else
    #user_stash = user_stash.uniq!
      # i = 0
      puts "=" * 22
      puts "Your stash cotains:"
      puts "-" * 22
      user_stash_names = user_stash.map do |strain|
        puts "-  #{strain.name}"
        #puts "#{i+1}. #{strain.name}"
        # i += 1
      end
      puts "~" * 22
    end
  end

  def create_stash_instance(current_strain_id)
    Stash.create(user_id: self.id, strain_id: current_strain_id)
  end

  def remove_strain_from_stash(current_strain)
    #binding.pry
    self.stash.each do |stashette|
        # binding.pry
      if stashette.strain_id == current_strain.id
        Stash.destroy(stashette.id)
      end
    end
  end

end