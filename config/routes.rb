Rails.application.routes.draw do
  get 'ebay/get_product'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'ebay#index'

  #get '/product', :to => 'ebay#index'
end
