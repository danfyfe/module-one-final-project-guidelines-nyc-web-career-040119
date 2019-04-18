#join table
class Stash < ActiveRecord::Base

  belongs_to :user
  has_many :strains
  
end