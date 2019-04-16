class User < ActiveRecord::Base

  has_many :strains, through: :stash






end