Rails.application.routes.draw do
  get 'ebay/get_product'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'ebay#index'

  post '/crawl', :to => 'ebay#crawl'

  post '/add_fixed_price_item', :to => 'ebay#add_fixed_price_item'
end
