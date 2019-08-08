class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.integer :glucose
      t.float :insulin
      t.integer :carbs
      t.string :note
      t.integer :user_id
      t.timestamps
    end
  end
end
