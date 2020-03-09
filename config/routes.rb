# frozen_string_literal: true

# Feel free to change whatever you like regarding the routes.
# This is just an example

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :rooms, except: %i[create destroy] do
        resources :bookings
      end

      resources :bookings, except: :create do
        resources :participants, except: :update
      end
      resources :users
    end
  end

  post 'auth/login', to: 'authentication#authenticate'
  post 'auth/register', to: 'users#create'
end
