class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.text :name
      t.text :description
      t.boolean :completed, default: false
      t.timestamps
    end
  end
end
