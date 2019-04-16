require_relative '../config/environment'
require 'rest-client'
require 'json'
require 'pry'


welcome
user_input = get_user_input
is_returning_user?(user_input)