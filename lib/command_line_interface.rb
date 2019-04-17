

def welcome
  puts "Welcome to Hempirical"
  puts "*" * 22
  puts "Please enter user name"
  puts "~" * 22
end

def get_user_input
  #puts "Please enter user name"
  input = gets.chomp
end

def is_returning_user?(user_input)

  # User.all.each do |user|
  #   if user.name.downcase == user_input.downcase
  #     puts "Welcome back, #{user_input}!"
  #   else
  #     User.create(name: user_input)
  #     puts "Welcome, #{user_input}!"
  #   end
  #
  # end
  #
  # if users.empty?
  #   User.create(name: user_input)
  #   puts "Welcome, #{user_input}!"
  # else
  #   puts "Welcome back, #{user_input}!"
  # end
  # puts "*" * 21
  #
  users = User.all.select do |user|
    user.name.downcase == user_input.downcase
  end

  if users.empty?
    User.find_or_create_by(name: user_input)
    puts "Welcome, #{user_input}!"
  else
    puts "Welcome back, #{user_input}!"
  end
  puts "*" * 22
end

def what_would_you_like_to_do
  puts "What would you like to do?"
  puts "1. Check stash"
  puts "2. Find a new strain"
end

def i_want_to_do_this(user_input,current_user)
  if user_input == "1" || user_input.downcase == "check stash"
      #binding.pry
    current_user.check_stash
  elsif user_input == "2" || user_input.downcase == "find a new strain"
    search_prompt
  end
end

### the check_stash method might need to be moved to User class as an instance method? and put the user.empty? logic into the run.rb or somewhere else. we need a way to
# def check_stash
#   puts "checking stash, brah"
#
# end

def search_prompt
  puts "Would you like to search by"
  puts "1. Name"
  puts "2. Species"
  puts "3. Symptoms"
end

def i_want_to_search_this_by(input)
  if input == "1" || input.downcase == "name"
    strain_name_prompt
    input = get_user_input
    strain_name_search(input)
    current_strain = Strain.all.find_by(name:input)
    input = get_user_input
    check_response(input,current_strain,@@current_user)
    #go to method to search by name
  elsif input == "2" || input.downcase == "species"
    species_prompt
    puts "~" * 22
    input = get_user_input
    puts "~" * 22
    species_search(input)
    #go to method to search by species
  elsif input == "3" || input.downcase == "symptoms"
    symptoms_prompt
    puts "~" * 22
    input = get_user_input
    symptoms_search(input)

    #go to method to search by symtoms
  end
end

def strain_name_prompt
  puts "~" * 22
  puts "Please enter strain name (case sensitive)"
  puts "~" * 22
end

def strain_name_search(input)
  results = Strain.all.select do |strain|
    strain.name.downcase == input.downcase
  end

#binding.pry
  if results.empty?
    puts "Sorry, strain not found"
    # we need a loop here? strain_name_prompt
  else
    puts "name: #{results[0].name}"
    puts "species: #{results[0].race}"
    puts "flavors: #{results[0].flavors}"
    puts "positive effects: #{results[0].positive_effects}"
    puts "negative effects: #{results[0].negative_effects}"
    puts "medical uses: #{results[0].medical_effects}"
    #results[0]
    puts "~" * 40
    puts "Would you like to put this in your stash? (yes/no)"
    #check_response(input)
  end
end

def check_response(input, current_strain, current_user)
  if input.downcase == "yes"
    #binding.pry
    current_user.create_stash_instance(current_strain.id)
    puts "#{current_strain.name} successfully added to stash!"
  else
    puts "Whatever, bro"
  end
  what_would_you_like_to_do
end

def species_prompt
  puts "~" * 22
  puts "Select species (case sensitive)"
  puts "~" * 22
  puts "1. Sativa"
  puts "2. Indica"
  puts "3. Hybrid"
end



def species_search(input)
  results = Strain.all.select do |strain|
    strain.race.downcase == input.downcase
  end
  sampled_results = results.sample(5)
  # i = 1
  # sampled_results.each do |sr|
  #   puts "#{i}. #{sr.name}"
  #   i += 1
  # end
  puts "Please enter strain name (case sensitive)"
  puts "1. #{sampled_results[0].name}"
  puts "2. #{sampled_results[1].name}"
  puts "3. #{sampled_results[2].name}"
  puts "4. #{sampled_results[3].name}"
  puts "5. #{sampled_results[4].name}"
  puts ""
  # puts "6. See more strains"
  puts "6. Search different species"
  puts "~" * 22
  input = get_user_input
  # if input.downcase == "see more strains" || input == "6"
  #   species_search()
  if input.downcase == "search different species" || input == "6"
    species_prompt
    puts "~" * 22
    input = get_user_input
    puts "~" * 22
    species_search(input)
  else
    strain_name_search(input)
    current_strain = Strain.all.find_by(name:input)
    input = get_user_input
    check_response(input,current_strain,@@current_user)
  end
end

def symptoms_prompt
  puts "~" * 22
  puts "Select a symptom"
  puts "~" * 22
  #stretch goal, allow for selecting multiple symptoms
  puts "1. Depression"
  puts "2. Insomnia"
  puts "3. Pain"
  puts "4. Stress"
  puts "5. Cramps"
  puts "6. Lack of Appetite"
  puts "7. Nausea"
  puts "9. Headaches" #ALSO SEARCH FOR HEADACHE
  puts "10. Fatiuge"
  puts "11. Eye Pressure"
  puts "12. Inflammation"
  puts "13. Spasticity"
  puts "14. Seizures"
  puts "15. Muscle Spasms"
  puts ""
  puts "16. Previous menu"
end

def symptoms_search(input)
  #binding.pry
  results = Strain.all.select do |strain|
    strain.medical_effects.downcase.include? input.downcase
  end
  sampled_results = results.sample(5)

  puts "Please enter strain name (case sensitive)"
  puts "1. #{sampled_results[0].name}"
  puts "2. #{sampled_results[1].name}"
  puts "3. #{sampled_results[2].name}"
  puts "4. #{sampled_results[3].name}"
  puts "5. #{sampled_results[4].name}"
  puts ""
  # puts "6. See more strains"
  puts "6. Search different symptom"
  puts "~" * 22
  input = get_user_input
  # if input.downcase == "see more strains" || input == "6"
  #   species_search()
  if input.downcase == "search different symptom" || input == "6"
    symptoms_prompt
    puts "~" * 22
    input = get_user_input
    puts "~" * 22
    symptoms_search(input)
  else
    strain_name_search(input)
    current_strain = Strain.all.find_by(name:input)
    input = get_user_input
    check_response(input,current_strain,@@current_user)
  end
end