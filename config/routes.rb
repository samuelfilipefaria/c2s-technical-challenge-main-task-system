Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "tasks#api_message"
  get "/tasks/get_all_tasks", to: "tasks#get_all_tasks"
  
  post "/user_tasks/create", to: "user_tasks#create"
  get "/user_tasks/get_a_task", to: "user_tasks#get_a_task"
  put "/user_tasks/update", to: "user_tasks#update"
  delete "/user_tasks/delete", to: "user_tasks#delete"

  post "/web_scraping_tasks/create", to: "web_scraping_tasks#create"
  get "/web_scraping_tasks/get_a_task", to: "web_scraping_tasks#get_a_task"
  put "/web_scraping_tasks/update", to: "web_scraping_tasks#update"
  delete "/web_scraping_tasks/delete", to: "web_scraping_tasks#delete"
end
