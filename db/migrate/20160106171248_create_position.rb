class CreatePosition < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.integer :game_id, null: false
      t.integer :player_id, null: false
      t.integer :x, null: false
      t.integer :y, null: false
      t.string :face, null: false
    end

    add_index :positions, [:game_id, :player_id]
  end
end
