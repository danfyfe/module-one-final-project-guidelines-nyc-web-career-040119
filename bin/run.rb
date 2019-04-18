require_relative '../config/environment'
require_all 'lib'
require 'rest-client'
require 'json'
require 'pry'


welcome
input = get_user_input
puts "*" * 22
is_returning_user?(input)
Current_user = User.all.find_by(name:input)
what_would_you_like_to_do_main
input = get_user_input
puts "~" * 22
i_want_to_do_this(input,Current_user)
# input = get_user_input
# i_want_to_search_this_by(input)
# input = get_user_input
# goodbye


# strain_name_search(input)
# current_strain = Strain.all.find_by(name:input)
# input = get_user_input
# check_response(input,current_strain,current_user)

# species_prompt
# input = get_user_input
# species_search(input)
