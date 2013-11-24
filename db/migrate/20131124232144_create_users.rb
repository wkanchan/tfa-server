class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :corporate_id
      t.string :passcode

      t.timestamps
    end
  end
end
