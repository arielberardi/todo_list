class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.string :status, null: false, default: 'pending'

      t.timestamps
    end

    add_index :tasks, :title, unique: true
  end
end
