class RenameBoardToPosition < ActiveRecord::Migration
  def self.up
    rename_table :boards, :positions
  end

 def self.down
    rename_table :positions, :boards
 end
end
