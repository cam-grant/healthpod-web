Rails.application.routes.draw do

  get   'consent' => 'welcome#consent'
  post  'consent' => 'welcome#consent'

  get   'returning-user' => 'welcome#returning_user'
  post  'returning-user' => 'welcome#returning_user'

  ####  Demographics

  get   'full-name' => 'demographics#full_name'
  post  'full-name' => 'demographics#full_name'

  get   'date-of-birth-and-gender' => 'demographics#date_of_birth_and_gender'
  post  'date-of-birth-and-gender' => 'demographics#date_of_birth_and_gender'

  get   'suburb' => 'demographics#suburb'
  post  'suburb' => 'demographics#suburb'

  get   'country-of-birth' => 'demographics#country_of_birth'
  post  'country-of-birth' => 'demographics#country_of_birth'

  get   'ethnicity' => 'demographics#ethnicity'
  post  'ethnicity' => 'demographics#ethnicity'

  get   'diabetes' => 'demographics#diabetes'
  post  'diabetes' => 'demographics#diabetes'

  ####  Allergies

  get   'allergies' => 'allergies#allergies'
  post  'allergies' => 'allergies#allergies'

  ####  BMI

  get   'bmi' => 'bmi#bmi'
  get   'bmi-read' => 'bmi#bmi_read'

  root  'welcome#welcome'

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
