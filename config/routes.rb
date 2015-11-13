Rails.application.routes.draw do

root to: "sites#index"
get "/", to: "sites#index"
     

get   "/sessions/new", to: "sessions#new", as: "new_session"
post  "/sessions"    , to:  "sessions#create", as: "sessions"
delete  "/sessions"  , to:  "sessions#destroy", as: "session"

 resources :users
 resources :rides do
    resources :rideprices
  end


# Prefix Verb   URI Pattern                                   Controller#Action
#                root GET    /                                             sites#index
#         new_session GET    /sessions/new(.:format)                       sessions#new
#            sessions POST   /sessions(.:format)                           sessions#create
#             session DELETE /sessions(.:format)                           sessions#destroy
#               users GET    /users(.:format)                              users#index
#                     POST   /users(.:format)                              users#create
#            new_user GET    /users/new(.:format)                          users#new
#           edit_user GET    /users/:id/edit(.:format)                     users#edit
#                user GET    /users/:id(.:format)                          users#show
#                     PATCH  /users/:id(.:format)                          users#update
#                     PUT    /users/:id(.:format)                          users#update
#                     DELETE /users/:id(.:format)                          users#destroy
#     ride_rideprices GET    /rides/:ride_id/rideprices(.:format)          rideprices#index
#                     POST   /rides/:ride_id/rideprices(.:format)          rideprices#create
#  new_ride_rideprice GET    /rides/:ride_id/rideprices/new(.:format)      rideprices#new
# edit_ride_rideprice GET    /rides/:ride_id/rideprices/:id/edit(.:format) rideprices#edit
#      ride_rideprice GET    /rides/:ride_id/rideprices/:id(.:format)      rideprices#show
#                     PATCH  /rides/:ride_id/rideprices/:id(.:format)      rideprices#update
#                     PUT    /rides/:ride_id/rideprices/:id(.:format)      rideprices#update
#                     DELETE /rides/:ride_id/rideprices/:id(.:format)      rideprices#destroy
#               rides GET    /rides(.:format)                              rides#index
#                     POST   /rides(.:format)                              rides#create
#            new_ride GET    /rides/new(.:format)                          rides#new
#           edit_ride GET    /rides/:id/edit(.:format)                     rides#edit
#                ride GET    /rides/:id(.:format)                          rides#show
#                     PATCH  /rides/:id(.:format)                          rides#update
#                     PUT    /rides/:id(.:format)                          rides#update
#                     DELETE /rides/:id(.:format)                          rides#destroy
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
