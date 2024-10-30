class CreateUserTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :user_tasks do |t|
      t.string :description
      t.string :state
      t.integer :creator_id

      t.timestamps
    end
  end
end
