Rails.application.routes.draw do

  get 'linkedin', to: 'openings#linkedin', as: :opening_linkedin
  get 'indeed', to: 'openings#indeed', as: :opening_indeed
  get 'nycstartup', to: 'openings#nycstartup', as: :opening_nyc
  
  resources :openings

end
