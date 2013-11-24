class CreateCorporates < ActiveRecord::Migration
  def change
    create_table :corporates do |t|
      t.string :name
      t.integer :status
      t.string :key

      t.timestamps
    end
  end
end
