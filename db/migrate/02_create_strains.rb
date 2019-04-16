class CreateStrains < ActiveRecord::Migration[4.2]

  def change
    create_table :strains do |t|
      t.string :name
      t.string :race
      t.string :flavors
      t.string :positive_effects
      t.string :negative_effects
      t.string :medical_effects
    end

  end


end