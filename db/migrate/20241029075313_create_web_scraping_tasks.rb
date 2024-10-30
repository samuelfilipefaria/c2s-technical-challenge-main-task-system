class CreateWebScrapingTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :web_scraping_tasks do |t|
      t.string :url_for_scraping
      t.string :state
      t.integer :creator_id

      t.timestamps
    end
  end
end
