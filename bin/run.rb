require_relative '../config/environment'
require_all 'lib'
require 'rest-client'
require 'json'
require 'pry'


welcome
input = get_user_input
puts "*" * 22
is_returning_user?(input)
what_would_you_like_to_do
input = get_user_input
i_want_to_do_this(input)
input = get_user_input
i_want_to_search_this_by(input)
input = get_user_input
puts "~" * 22
strain_name_search(input)
input = get_user_input



