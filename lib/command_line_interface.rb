# welcome message
def welcome
  puts "
                            .--:::::--`      ``      `--:::::-..
                        `.://////////::.   .////.   .:://////////:.`
                    `.-:///////////////:`  .////-   :///////////////:-.`
                `.-///::://////////////-.  `-::-`  .-//////////////::////-.`
            .-:///:::://///////////////::   -//-   -://///////////////::::///:-.
      `.-:////:--://////////////////////::---//---:://////////////////////:--:////:-.`
 `.-:////:---://///////::///////////////////-//-//////////////////::://///////:---:////:-.`
        `-////////::::://///////////////////-//-/////////////////////:::::////////-`
        `.......--://////:::////////////////-//-/////////////////:://////:--.......`
               ://:::---://///::////////////-//-////////////:://///:---::///:
                      .//::-`-/////:////////-//-////////://///-.-:://.
                            `:::-..///-://:`.//.`://:-///-.-:/:`
                                   `` `--.` .//` `.--` ``
                                    `//////`.//`./:///:`
                                   -///:-.` .//` `-::///.
                                  `///-     `//`     :///
                                   -////-`  `//   .-////.
                                    `-/////:-::-:////:-
                                       `.-:////:::-`
                                       .://:.::-///-.
                                      ://-` `//  `://-
                                      ///`  `/:   -//:
                                      `-///-`/:`-//:.
                                         .-::://:-`
                                          .:/::::.
                                        `//-`/:`:/:`
                                        //.  /-  -/:
                                        :/-  /- `:/.
                                         .//.:--/:`
                                           -/:::.
                                           -::::.
                                         `/:`:../:
                                         -/` :. ./`
                                         `:: :.`:-
                                           .:--:`
                                            `--
                                            --..
                                            .-``
                                            `-
                                             .
                                                       ".green

  puts "Welcome to" +" Hempirical".green + "!"
  puts "The leader in medical marijuana management."
  puts "*" * 22
  puts "Please enter user name:"
  puts "~" * 22
end

# goodbye message
def goodbye
  puts "Thank you for using " + "Hempirical".green + "!"
  puts "The leader in medical marijuana management."
end

# invalid command messge
def invalid_command
  puts "Sorry, invalid command"
  puts "#" * 22
end
def quit
  goodbye
end

# user input
def get_user_input
  input = gets.chomp
end

# checks if user is in the db
def is_returning_user?(user_input)
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

# main menu prompt
def what_would_you_like_to_do_main
  puts "What would you like to do?"
  puts "*" * 22
  puts "1. Check stash"
  puts "2. Find a new strain"
  puts "3. Quit"
  puts "~" * 22
end

# main menu logic
def i_want_to_do_this(user_input,current_user)
  if user_input == "1" || user_input.downcase == "check stash"
    check_stash_prompt
    check_stash_prompt_answer
  elsif user_input == "2" || user_input.downcase == "find a new strain"
    search_prompt
    input = get_user_input
    i_want_to_search_this_by(input)
  elsif user_input == "3" || user_input.downcase == "quit"
    quit
  else
    invalid_command
    what_would_you_like_to_do_main
    user_input = get_user_input
    i_want_to_do_this(user_input, current_user)
  end
end

# checking stash menu prompt
def check_stash_prompt
  Current_user.check_stash
  puts "What would you like to?"
  puts "~" * 22
  puts "1. View strain info"
  puts "2. Edit Stash"
  puts "3. Previous menu"
  puts "4. Quit"
  puts "~" * 22
end

# checking stash menu logic
def check_stash_prompt_answer
  input = get_user_input
  if input == "1" || input.downcase == "view strain info"
    strain_name_prompt
    input = get_user_input
    stash_strain_info(input)
    current_strain = Strain.all.find_by(name:input)
    input = get_user_input
  elsif input == "2" || input.downcase == "edit stash"
    stash_edit_prompt
  elsif input == "3" || input.downcase == "previous menu"
    what_would_you_like_to_do_main
    user_input = get_user_input
    i_want_to_do_this(user_input,Current_user)
  elsif input == "4" || input.downcase == "quit"
    quit
  else
    invalid_command
    check_stash_prompt
    check_stash_prompt_answer
  end
end

# stash strain info
def stash_strain_info(input)
  current_strain = Strain.all.find_by(name:input)
  results = Strain.all.select do |strain|
    strain.name.downcase == input.downcase
  end
    if results.empty?
      puts "Sorry, strain not found"
      puts "*" * 22
      what_would_you_like_to_do_main
      user_input = get_user_input
      i_want_to_do_this(user_input,Current_user)
    else
      puts "name: #{results[0].name}"
      puts "species: #{results[0].race}"
      puts "flavors: #{results[0].flavors}"
      puts "positive effects: #{results[0].positive_effects}"
      puts "negative effects: #{results[0].negative_effects}"
      puts "medical uses: #{results[0].medical_effects}"
      puts "~" * 40
      puts "Would you like to remove this from your stash? (yes/no)"
      input = get_user_input
      if input.downcase == "yes"
        Current_user.remove_strain_from_stash(current_strain)
        puts "!" * 22
        puts "#{current_strain.name} successfully removed from stash!"
        check_stash_prompt
        check_stash_prompt_answer
      elsif input.downcase == "no"
        puts "~" * 22
        check_stash_prompt
        check_stash_prompt_answer
      end
    end
end

# edit stash prompt
def stash_edit_prompt
  puts "~" * 22
  Current_user.check_stash
  puts "How would you like to edit your stash?"
  puts "~" * 22
  puts "1. Add"
  puts "2. Remove"
  puts "3. Previous menu"
  puts "4. Quit"
  puts "~" * 22
  input = get_user_input
  if input == "1" || input.downcase == "add"
    search_prompt
    input = get_user_input
    i_want_to_search_this_by(input)

  elsif input == "2" || input.downcase == "remove"
    puts "Please enter strain name you would like to remove (case sensitive)"
    input = get_user_input
    current_strain = Strain.all.find_by(name:input)
    Current_user.remove_strain_from_stash(current_strain)
    puts "#{current_strain.name} successfully removed from stash!"
    check_stash_prompt
    check_stash_prompt_answer
  elsif input == "3" || input.downcase == "previous menu"
    check_stash_prompt
    check_stash_prompt_answer
  elsif input == "4" || input.downcase == "quit"
    quit
  end
end

# search by prompt
def search_prompt
  puts "What would you like to search by?"
  puts "~" * 22
  puts "1. Name"
  puts "2. Species"
  puts "3. Symptom"
  puts "4. Previous menu"
  puts "5. Quit"
  puts "~" * 22
end

# search by menu logic
def i_want_to_search_this_by(input)
  if input == "1" || input.downcase == "name"
    strain_name_prompt
    input = get_user_input
    strain_name_search(input)
    current_strain = Strain.all.find_by(name:input)
    input = get_user_input
    check_response(input,current_strain,Current_user)
  elsif input == "2" || input.downcase == "species"
    species_prompt
    puts "~" * 22
    input = get_user_input
    puts "~" * 22
    species_search(input)
  elsif input == "3" || input.downcase == "symptom"
    symptoms_prompt
    puts "~" * 22
    input = get_user_input
    puts "~" * 22
    symptoms_search(input)
  elsif input == "4" || input.downcase == "previous menu"
    what_would_you_like_to_do_main
    user_input = get_user_input
    i_want_to_do_this(user_input,Current_user)
  elsif input == "5" || input.downcase == "quit"
    quit
  else
    invalid_command
    search_prompt
    input = get_user_input
    i_want_to_search_this_by(input)
  end
end

# search by strain name prompt
def strain_name_prompt
  puts "~" * 22
  puts "Please enter strain name (case sensitive)"
  puts "~" * 22
end

# search by strain name logic
def strain_name_search(input)
  results = Strain.all.select do |strain|
    strain.name.downcase == input.downcase
  end
  if results.empty?
    puts "Sorry, strain not found"
    puts "*" * 22
    what_would_you_like_to_do_main
    user_input = get_user_input
    i_want_to_do_this(user_input,Current_user)
  else
    puts "name: #{results[0].name}"
    puts "species: #{results[0].race}"
    puts "flavors: #{results[0].flavors}"
    puts "positive effects: #{results[0].positive_effects}"
    puts "negative effects: #{results[0].negative_effects}"
    puts "medical uses: #{results[0].medical_effects}"
    puts "~" * 22
    puts "Would you like to put this in your stash? (yes/no)"
    puts "~" * 22
  end
end

# add strain to stash logic -- bad method name :(
def check_response(input, current_strain, current_user)
  if input.downcase == "yes"
    current_user.create_stash_instance(current_strain.id)
    puts "!" * 22
    puts "#{current_strain.name} successfully added to stash!"
    puts "~" * 22
    what_would_you_like_to_do_main
    user_input = get_user_input
    puts "#" * 22
    i_want_to_do_this(user_input,current_user)
  end
  what_would_you_like_to_do_main
  user_input = get_user_input
  i_want_to_do_this(user_input,Current_user)
end

# search by species menu prompt
def species_prompt
  puts "~" * 22
  puts "Select species"
  puts "~" * 22
  puts "1. Sativa"
  puts "2. Indica"
  puts "3. Hybrid"
end

# search by species menu logic
def species_search(input)
  if input.downcase == "sativa" || input == "1"
    results = Strain.all.select do |strain|
      strain.race.downcase == "sativa"
    end
  elsif input.downcase == "indica" || input == "2"
    results = Strain.all.select do |strain|
      strain.race.downcase == "indica"
    end
  elsif input.downcase == "hybrid" || input == "3"
    results = Strain.all.select do |strain|
      strain.race.downcase == "hybrid"
    end
  end
  #results = Strain.all.select do |strain|
  #  strain.race.downcase == input.downcase
  #end
  sampled_results = results.sample(5)

  # strain_name_prompt
  strain_name_prompt
  puts "- #{sampled_results[0].name}"
  puts "- #{sampled_results[1].name}"
  puts "- #{sampled_results[2].name}"
  puts "- #{sampled_results[3].name}"
  puts "- #{sampled_results[4].name}"
  puts ""
  puts "Or search different species"
  puts "~" * 22
  input = get_user_input

  if input.downcase == "search different species"
    species_prompt
    puts "~" * 22
    input = get_user_input
    puts "~" * 22
    species_search(input)
  else
    strain_name_search(input)
    current_strain = Strain.all.find_by(name:input)
    input = get_user_input
    check_response(input,current_strain,Current_user)
  end
end

# search by symyptoms menu prompt
def symptoms_prompt
  puts "~" * 22
  puts "Select a symptom (case sensitive)"
  puts "~" * 22
  puts "1. Depression"
  puts "2. Insomnia"
  puts "3. Pain"
  puts "4. Stress"
  puts "5. Cramps"
  puts "6. Lack of Appetite"
  puts "7. Nausea"
  puts "8. Headaches"
  puts "9. Fatiuge"
  puts "10. Eye Pressure"
  puts "11. Inflammation"
  puts "12. Spasticity"
  puts "13. Seizures"
  puts "14. Muscle Spasms"
  puts ""
  puts "15. Previous menu"
end

# search by symptoms menu logic
def symptoms_search(input)
  all_medical_effects = Strain.all.select do |strain|
    strain.medical_effects
  end
  if input.downcase == "depression" || input == "1"
    results = Strain.all.select do |strain|
      strain.medical_effects.include? "Depression"
    end
    sampled_results = results.sample(5)
    # strain_name_prompt
    strain_name_prompt
    puts "- #{sampled_results[0].name}"
    puts "- #{sampled_results[1].name}"
    puts "- #{sampled_results[2].name}"
    puts "- #{sampled_results[3].name}"
    puts "- #{sampled_results[4].name}"
    puts ""
    puts "Or search different symptom"
    puts "~" * 22
    input = get_user_input
    if input.downcase == "search different symptom"
      symptoms_prompt
      puts "~" * 22
      input = get_user_input
      puts "~" * 22
      symptoms_search(input)
    else
      strain_name_search(input)
      current_strain = Strain.all.find_by(name:input)
      input = get_user_input
      check_response(input,current_strain,Current_user)
    end
  elsif input.downcase == "insomnia" || input == "2"
    results = Strain.all.select do |strain|
      strain.medical_effects.include? "Insomnia"
    end
    sampled_results = results.sample(5)
    strain_name_prompt
    puts "- #{sampled_results[0].name}"
    puts "- #{sampled_results[1].name}"
    puts "- #{sampled_results[2].name}"
    puts "- #{sampled_results[3].name}"
    puts "- #{sampled_results[4].name}"
    puts ""
    puts "Or search different symptom"
    puts "~" * 22
    input = get_user_input

    if input.downcase == "search different symptom"
      symptoms_prompt
      puts "~" * 22
      input = get_user_input
      puts "~" * 22
      symptoms_search(input)
    else
      strain_name_search(input)
      current_strain = Strain.all.find_by(name:input)
      input = get_user_input
      check_response(input,current_strain,Current_user)
    end
  elsif input.downcase == "pain" || input == "3"
    results = Strain.all.select do |strain|
      strain.medical_effects.include? "Pain"
    end
    sampled_results = results.sample(5)
    strain_name_prompt
    puts "- #{sampled_results[0].name}"
    puts "- #{sampled_results[1].name}"
    puts "- #{sampled_results[2].name}"
    puts "- #{sampled_results[3].name}"
    puts "- #{sampled_results[4].name}"
    puts ""
    puts "Or search different symptom"
    puts "~" * 22
    input = get_user_input

    if input.downcase == "search different symptom"
      symptoms_prompt
      puts "~" * 22
      input = get_user_input
      puts "~" * 22
      symptoms_search(input)
    else
      strain_name_search(input)
      current_strain = Strain.all.find_by(name:input)
      input = get_user_input
      check_response(input,current_strain,Current_user)
    end
  elsif input.downcase == "stress" || input == "4"
    results = Strain.all.select do |strain|
      strain.medical_effects.include? "Stress"
    end
    sampled_results = results.sample(5)
    strain_name_prompt
    puts "- #{sampled_results[0].name}"
    puts "- #{sampled_results[1].name}"
    puts "- #{sampled_results[2].name}"
    puts "- #{sampled_results[3].name}"
    puts "- #{sampled_results[4].name}"
    puts ""
    puts "Or search different symptom"
    puts "~" * 22
    input = get_user_input

    if input.downcase == "search different symptom"
      symptoms_prompt
      puts "~" * 22
      input = get_user_input
      puts "~" * 22
      symptoms_search(input)
    else
      strain_name_search(input)
      current_strain = Strain.all.find_by(name:input)
      input = get_user_input
      check_response(input,current_strain,Current_user)
    end
  elsif input.downcase == "cramps" || input == "5"
    results = Strain.all.select do |strain|
      strain.medical_effects.include? "Cramps"
    end
    sampled_results = results.sample(5)
    strain_name_prompt
    puts "- #{sampled_results[0].name}"
    puts "- #{sampled_results[1].name}"
    puts "- #{sampled_results[2].name}"
    puts "- #{sampled_results[3].name}"
    puts "- #{sampled_results[4].name}"
    puts ""
    puts "Or search different symptom"
    puts "~" * 22
    input = get_user_input

    if input.downcase == "search different symptom"
      symptoms_prompt
      puts "~" * 22
      input = get_user_input
      puts "~" * 22
      symptoms_search(input)
    else
      strain_name_search(input)
      current_strain = Strain.all.find_by(name:input)
      input = get_user_input
      check_response(input,current_strain,Current_user)
    end
  elsif input.downcase == "lack of appetite" || input == "6"
    results = Strain.all.select do |strain|
      strain.medical_effects.include? "Lack of Appetite"
    end
    sampled_results = results.sample(5)
    strain_name_prompt
    puts "- #{sampled_results[0].name}"
    puts "- #{sampled_results[1].name}"
    puts "- #{sampled_results[2].name}"
    puts "- #{sampled_results[3].name}"
    puts "- #{sampled_results[4].name}"
    puts ""
    puts "Or search different symptom"
    puts "~" * 22
    input = get_user_input

    if input.downcase == "search different symptom"
      symptoms_prompt
      puts "~" * 22
      input = get_user_input
      puts "~" * 22
      symptoms_search(input)
    else
      strain_name_search(input)
      current_strain = Strain.all.find_by(name:input)
      input = get_user_input
      check_response(input,current_strain,Current_user)
    end
  elsif input.downcase == "nausea" || input == "7"
    results = Strain.all.select do |strain|
      strain.medical_effects.include? "Nausea"
    end
    sampled_results = results.sample(5)
    strain_name_prompt
    puts "- #{sampled_results[0].name}"
    puts "- #{sampled_results[1].name}"
    puts "- #{sampled_results[2].name}"
    puts "- #{sampled_results[3].name}"
    puts "- #{sampled_results[4].name}"
    puts ""
    puts "Or search different symptom"
    puts "~" * 22
    input = get_user_input

    if input.downcase == "search different symptom"
      symptoms_prompt
      puts "~" * 22
      input = get_user_input
      puts "~" * 22
      symptoms_search(input)
    else
      strain_name_search(input)
      current_strain = Strain.all.find_by(name:input)
      input = get_user_input
      check_response(input,current_strain,Current_user)
    end
  elsif input.downcase == "headaches" || input == "8"
    results = Strain.all.select do |strain|
      strain.medical_effects.include? "Headache"
    end
    sampled_results = results.sample(5)
    strain_name_prompt
    puts "- #{sampled_results[0].name}"
    puts "- #{sampled_results[1].name}"
    puts "- #{sampled_results[2].name}"
    puts "- #{sampled_results[3].name}"
    puts "- #{sampled_results[4].name}"
    puts ""
    puts "Or search different symptom"
    puts "~" * 22
    input = get_user_input

    if input.downcase == "search different symptom"
      symptoms_prompt
      puts "~" * 22
      input = get_user_input
      puts "~" * 22
      symptoms_search(input)
    else
      strain_name_search(input)
      current_strain = Strain.all.find_by(name:input)
      input = get_user_input
      check_response(input,current_strain,Current_user)
    end
  elsif input.downcase == "fatigue" || input == "9"
    results = Strain.all.select do |strain|
      strain.medical_effects.include? "Fatigue"
    end
    sampled_results = results.sample(5)
    strain_name_prompt
    puts "- #{sampled_results[0].name}"
    puts "- #{sampled_results[1].name}"
    puts "- #{sampled_results[2].name}"
    puts "- #{sampled_results[3].name}"
    puts "- #{sampled_results[4].name}"
    puts ""
    puts "Or search different symptom"
    puts "~" * 22
    input = get_user_input

    if input.downcase == "search different symptom"
      symptoms_prompt
      puts "~" * 22
      input = get_user_input
      puts "~" * 22
      symptoms_search(input)
    else
      strain_name_search(input)
      current_strain = Strain.all.find_by(name:input)
      input = get_user_input
      check_response(input,current_strain,Current_user)
    end
  elsif input.downcase == "eye pressure" || input == "10"
    results = Strain.all.select do |strain|
      strain.medical_effects.include? "Eye Pressure"
    end
    sampled_results = results.sample(5)
    strain_name_prompt
    puts "- #{sampled_results[0].name}"
    puts "- #{sampled_results[1].name}"
    puts "- #{sampled_results[2].name}"
    puts "- #{sampled_results[3].name}"
    puts "- #{sampled_results[4].name}"
    puts ""
    puts "Or search different symptom"
    puts "~" * 22
    input = get_user_input

    if input.downcase == "search different symptom"
      symptoms_prompt
      puts "~" * 22
      input = get_user_input
      puts "~" * 22
      symptoms_search(input)
    else
      strain_name_search(input)
      current_strain = Strain.all.find_by(name:input)
      input = get_user_input
      check_response(input,current_strain,Current_user)
    end
  elsif input.downcase == "inflammation" || input == "11"
    results = Strain.all.select do |strain|
      strain.medical_effects.include? "Inflammation"
    end
    sampled_results = results.sample(5)
    strain_name_prompt
    puts "- #{sampled_results[0].name}"
    puts "- #{sampled_results[1].name}"
    puts "- #{sampled_results[2].name}"
    puts "- #{sampled_results[3].name}"
    puts "- #{sampled_results[4].name}"
    puts ""
    puts "Or search different symptom"
    puts "~" * 22
    input = get_user_input

    if input.downcase == "search different symptom"
      symptoms_prompt
      puts "~" * 22
      input = get_user_input
      puts "~" * 22
      symptoms_search(input)
    else
      strain_name_search(input)
      current_strain = Strain.all.find_by(name:input)
      input = get_user_input
      check_response(input,current_strain,Current_user)
    end
  elsif input.downcase == "spasticity" || input == "12"
    results = Strain.all.select do |strain|
      strain.medical_effects.include? "Spasticity"
    end
    sampled_results = results.sample(5)
    strain_name_prompt
    puts "- #{sampled_results[0].name}"
    puts "- #{sampled_results[1].name}"
    puts "- #{sampled_results[2].name}"
    puts "- #{sampled_results[3].name}"
    puts "- #{sampled_results[4].name}"
    puts ""
    puts "Or search different symptom"
    puts "~" * 22
    input = get_user_input

    if input.downcase == "search different symptom"
      symptoms_prompt
      puts "~" * 22
      input = get_user_input
      puts "~" * 22
      symptoms_search(input)
    else
      strain_name_search(input)
      current_strain = Strain.all.find_by(name:input)
      input = get_user_input
      check_response(input,current_strain,Current_user)
    end
  elsif input.downcase == "seizures" || input == "13"
    results = Strain.all.select do |strain|
      strain.medical_effects.include? "Seizures"
    end
    sampled_results = results.sample(5)
    strain_name_prompt
    puts "- #{sampled_results[0].name}"
    puts "- #{sampled_results[1].name}"
    puts "- #{sampled_results[2].name}"
    puts "- #{sampled_results[3].name}"
    puts "- #{sampled_results[4].name}"
    puts ""
    puts "Or search different symptom"
    puts "~" * 22
    input = get_user_input

    if input.downcase == "search different symptom"
      symptoms_prompt
      puts "~" * 22
      input = get_user_input
      puts "~" * 22
      symptoms_search(input)
    else
      strain_name_search(input)
      current_strain = Strain.all.find_by(name:input)
      input = get_user_input
      check_response(input,current_strain,Current_user)
    end
  elsif input.downcase == "muscle spasms" || input == "14"
    results = Strain.all.select do |strain|
      strain.medical_effects.include? "Muscle Spasms"
    end
    sampled_results = results.sample(5)
    strain_name_promot
    puts "- #{sampled_results[0].name}"
    puts "- #{sampled_results[1].name}"
    puts "- #{sampled_results[2].name}"
    puts "- #{sampled_results[3].name}"
    puts "- #{sampled_results[4].name}"
    puts ""
    puts "Or search different symptom"
    puts "~" * 22
    input = get_user_input

    if input.downcase == "search different symptom"
      symptoms_prompt
      puts "~" * 22
      input = get_user_input
      puts "~" * 22
      symptoms_search(input)
    else
      strain_name_search(input)
      current_strain = Strain.all.find_by(name:input)
      input = get_user_input
      check_response(input,current_strain,Current_user)
    end
  elsif input.downcase == "previous menu" || input == "15"
    search_prompt
    input = get_user_input
    i_want_to_search_this_by(input)
  else
    puts "#" * 22
    puts "Sorry, #{input} is not a searchable symptom"
    symptoms_prompt
    puts "~" * 22
    input = get_user_input
    symptoms_search(input)
  end
end

