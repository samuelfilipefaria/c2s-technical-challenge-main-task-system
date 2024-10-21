class CreateTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks do |t|
      t.string :description
      t.string :user_id
      t.string :state
      t.string :type
      t.string :url_for_scraping

      t.timestamps
    end
  end
end
