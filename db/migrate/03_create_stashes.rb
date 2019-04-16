class CreateStashes < ActiveRecord::Migration[4.2]

  def change
    create_table :stashes do |t|
      t.integer :user_id
      t.integer :strain_id
    end
  end


end