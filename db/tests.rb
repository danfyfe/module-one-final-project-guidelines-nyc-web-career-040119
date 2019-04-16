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