Rails.application.routes.draw do
  resources :tasks, except: [:show]
  post "/tasks/:id/toggle_status" => "tasks#toggle_status", as: :toggle_status_task

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "tasks#index"
end
