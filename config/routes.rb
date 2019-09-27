Rails.application.routes.draw do
  get '/appointments/:id', to: 'appointments#show'
  get '/users/sign-in', to: 'users#sign_in'
  get '/users/sign-up', to: 'users#sign_up'
  get '/users/:id/appointments', to: 'users#appointments'
end
