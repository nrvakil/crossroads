class CreateBoard < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.integer :game_id, null: false
      t.integer :player_id, null: false
      t.integer :x, null: false
      t.integer :y, null: false
      t.string :face, null: false
    end

    add_index :boards, [:game_id, :player_id]
  end
end
