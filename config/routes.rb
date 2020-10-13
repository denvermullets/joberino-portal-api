Rails.application.routes.draw do

  get 'linkedin', to: 'openings#linkedin', as: :opening_linkedin
  get 'indeed', to: 'openings#indeed', as: :opening_indeed
  
  resources :openings

end
