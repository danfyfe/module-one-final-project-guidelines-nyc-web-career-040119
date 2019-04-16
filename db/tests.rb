# response_hash.map do |strain_name,strain_info|
#   strain_info["effects"]["medical"]
# end


# def find_by_medical_effects(medical_effect)
#   response_hash.select do |strain_name,strain_info|
#     strain_info["effects"]["medical"] == medical_effect
#   end
# end

eye_pressure = response_hash.select do |strain_name,strain_info|
  strain_info["effects"]["medical"].include? "Eye Pressure"
end.to_a.sample(n)

#What would you like to do?
#1. Check stash
  #if it's empty, return "Your stash is empty"
  #else list what is in stash
#2. Find a new strain

#if 2,
#Search by name?
#Search by species?
  #enter the number or name that you want to search
  #1. sativa
  #2. indica
  #3. hybrid
#Search by symptoms?
  #What symptom would you like to address?
  #1. headache
  #...
  #n. Muscle Spasms

#return appropritate list of randomly selected 5 names
  #1. name
    #see in detail
  #2. name2
  #3. name3
  #4. name4
  #5. name5
  #6. see more options?
    #run again
  #7. try a new search
    #lead back to step 2
  #or input the strain you want to see in detail (name or #)
