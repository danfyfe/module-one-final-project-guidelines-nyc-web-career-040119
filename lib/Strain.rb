class Strain < ActiveRecord::Base

  has_many :users, through: :stash


## method to find strain by medical_effect
  # def find_by_medical_effects(*medical_effect)
  #   response_hash.select do |strain_name,strain_info|
  #     strain_info["effects"]["medical"].include? medical_effect
  #   end.to_a.sample(5)
  # end

  # def strain_expand
  #
  # end

end