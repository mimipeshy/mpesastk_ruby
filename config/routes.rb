Rails.application.routes.draw do
  resources :mpesas
  post "/stkpush", to: "mpesas#stkpush"
  post "/stkquery", to: "mpesas#stkquery"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
