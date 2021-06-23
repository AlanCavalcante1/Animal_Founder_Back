class CreateAnimals < ActiveRecord::Migration[5.2]
  def change
    create_table :animals do |t|
      t.string :photo
      t.string :name
      t.integer :age
      t.string :description
      t.string :city
      t.string :state
      t.integer :status, default: 0
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
