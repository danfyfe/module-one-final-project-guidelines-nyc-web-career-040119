require_relative '../config/environment'
require_all 'lib'
require 'rest-client'
require 'json'
require 'pry'


welcome
input = get_user_input
puts "*" * 22
is_returning_user?(input)
@@current_user = User.all.find_by(name:input)
#binding.pry
what_would_you_like_to_do
input = get_user_input
i_want_to_do_this(input,@@current_user)
input = get_user_input
i_want_to_search_this_by(input)
input = get_user_input
puts "~" * 22


# strain_name_search(input)
# current_strain = Strain.all.find_by(name:input)
# input = get_user_input
# check_response(input,current_strain,current_user)

# species_prompt
# input = get_user_input
# species_search(input)
