require 'dotenv/load'
require 'rest-client'
require 'json'
require 'bundler'
Bundler.require

$key = ENV["API_KEY"]

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'

## Seed Users and pupulate database with API data
def seed_with_api_data
  response_string = RestClient.get("http://strainapi.evanbusse.com/#{$key}/strains/search/all")
  response_hash = JSON.parse(response_string)

  # below populates our database with the API data
  response_hash.each do |strain_name,strain_attributes|
    name = strain_name
    strain_id = strain_attributes["id"]
    race = strain_attributes["race"]
    flavors = strain_attributes["flavors"].join(", ")
    positive_effects = strain_attributes["effects"]["positive"].join(", ")
    negative_effects = strain_attributes["effects"]["negative"].join(", ")
    medical_effects = strain_attributes["effects"]["medical"].join(", ")

    new_strain = Strain.create(id: strain_id, name:strain_name, race: race, flavors: flavors, positive_effects: positive_effects, negative_effects: negative_effects, medical_effects: medical_effects)
  end
end

def create_stock_users
  User.find_or_create_by(name:"John")
  User.find_or_create_by(name:"Paul")
  User.find_or_create_by(name:"George")
  User.find_or_create_by(name:"Ringo")
end

def create_stock_users_stashes
  Stash.create(user_id: 1, strain_id: 1842)
  Stash.create(user_id: 2, strain_id: 656)
  Stash.create(user_id: 3, strain_id: 337)
  Stash.create(user_id: 4, strain_id: 1459)
  Stash.create(user_id: 4, strain_id: 1721)
end

seed_with_api_data
create_stock_users
create_stock_users_stashes
