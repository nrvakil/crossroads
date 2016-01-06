class CreateGame < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :player_ids, array: true, null: false
      t.integer :winners, array: true
    end
  end
end
