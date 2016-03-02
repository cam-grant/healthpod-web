Rails.application.routes.draw do

  ####  Welcome / hub

  root  'welcome#welcome'

  get   'consent' => 'welcome#consent'
  post  'consent' => 'welcome#consent'

  get   'returning-user' => 'welcome#returning_user'
  post  'returning-user' => 'welcome#returning_user'

  get   'hub' => 'welcome#hub'

  get   'print' => 'welcome#print'

  ####  Demographics

  get   'full-name' => 'demographics#full_name'
  post  'full-name' => 'demographics#full_name'

  get   'date-of-birth-and-gender' => 'demographics#date_of_birth_and_gender'
  post  'date-of-birth-and-gender' => 'demographics#date_of_birth_and_gender'

  get   'suburb' => 'demographics#suburb'
  post  'suburb' => 'demographics#suburb'

  get   'country-of-birth' => 'demographics#country_of_birth'
  post  'country-of-birth' => 'demographics#country_of_birth'

  get   'aboriginal' => 'demographics#aboriginal'
  post  'aboriginal' => 'demographics#aboriginal'

  get   'has_diabetes' => 'demographics#has_diabetes'
  post  'has_diabetes' => 'demographics#has_diabetes'

  get   'smoking' => 'demographics#smoking'
  post  'smoking' => 'demographics#smoking'

  ####  Allergies

  get   'has-allergies' => 'allergies#has_allergies'
  post  'has-allergies' => 'allergies#has_allergies'

  get   'allergy-list' => 'allergies#allergy_list'
  post  'allergy-list' => 'allergies#allergy_list'

  ####  BMI

  get   'bmi' => 'bmi#bmi'
  get   'bmi-read' => 'bmi#bmi_read'

  ####  Diabetes

  get   'diabetes' => 'diabetes#welcome'

  ####  Physical

  get   'physical' => 'physical#welcome'

  ####  Alcohol

  get   'alcohol' => 'alcohol#welcome'


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
