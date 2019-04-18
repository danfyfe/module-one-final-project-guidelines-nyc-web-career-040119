class Strain < ActiveRecord::Base

  has_many :users, through: :stash

end