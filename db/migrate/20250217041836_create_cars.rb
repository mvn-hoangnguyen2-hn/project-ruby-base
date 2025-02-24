class CreateCars < ActiveRecord::Migration[8.0]
  def change
    create_table :cars do |t|
      t.references :user, null: false, foreign_key: true
      t.string :make
      t.string :model
      t.string :color
      t.string :license_plate
      t.integer :status

      t.timestamps
    end
  end
end
