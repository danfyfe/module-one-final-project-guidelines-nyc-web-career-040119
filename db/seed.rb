
## Seed Users

response_string = RestClient.get('http://strainapi.evanbusse.com/IIFiO79/strains/search/all')

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

