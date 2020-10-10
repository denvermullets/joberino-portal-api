Rails.application.routes.draw do

  get 'linkedin', to: 'openings#linkedin', as: :opening_linkedin
  
  resources :openings

end
