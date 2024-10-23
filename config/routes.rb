Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "tasks#api_message"
  get "/tasks/get_all_tasks", to: "tasks#get_all_tasks"
  get "/tasks/get_a_task", to: "tasks#get_a_task"
  post "/tasks/create", to: "tasks#create"
  put "/tasks/edit", to: "tasks#edit"
  delete "/tasks/delete", to: "tasks#delete"
end
