class WebScrapingTask < ApplicationRecord
  validates_presence_of :url_for_scraping, :state, :creator_id
  validates :url_for_scraping, uniqueness: true
end
