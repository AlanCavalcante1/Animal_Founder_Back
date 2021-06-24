class ChangeTypeStateToAnimals < ActiveRecord::Migration[5.2]
  def change
    change_column :animals, :state, :integer, default: 0
  end
end
