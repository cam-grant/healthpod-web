Rails.application.routes.draw do

  ####  Welcome / hub

  root  'welcome#welcome'

  get   'consent' => 'welcome#consent'
  post  'consent' => 'welcome#consent'

  get   'returning-user' => 'welcome#returning_user'
  post  'returning-user' => 'welcome#returning_user'

  get   'hub' => 'welcome#hub'

  get   'print' => 'welcome#print'

  ####  Basic health check

  get   'full-name' => 'basic#full_name'
  post  'full-name' => 'basic#full_name'

  get   'date-of-birth-and-gender' => 'basic#date_of_birth_and_gender'
  post  'date-of-birth-and-gender' => 'basic#date_of_birth_and_gender'

  get   'suburb' => 'basic#suburb'
  post  'suburb' => 'basic#suburb'

  get   'country-of-birth' => 'basic#country_of_birth'
  post  'country-of-birth' => 'basic#country_of_birth'

  get   'aboriginal' => 'basic#aboriginal'
  post  'aboriginal' => 'basic#aboriginal'

  get   'smoking' => 'basic#smoking'
  post  'smoking' => 'basic#smoking'

  get   'allergies' => 'basic#allergies'
  post  'allergies' => 'basic#allergies'

  get   'other-allergies' => 'basic#other_allergies'
  post  'other-allergies' => 'basic#other_allergies'

  get   'bmi' => 'basic#bmi'
  get   'bmi-read' => 'basic#bmi_read'

  get   'has_diabetes' => 'basic#has_diabetes'
  post  'has_diabetes' => 'basic#has_diabetes'

  ####  Diabetes

  get   'diabetes-welcome' => 'diabetes#welcome'
  
  get   'diabetes-age-group' => 'diabetes#age_group'
  post  'diabetes-age-group' => 'diabetes#age_group'

  get   'diabetes-hereditary' => 'diabetes#hereditary'
  post  'diabetes-hereditary' => 'diabetes#hereditary'

  get   'diabetes-high-blood-glucose' => 'diabetes#high_blood_glucose'
  post  'diabetes-high-blood-glucose' => 'diabetes#high_blood_glucose'

  get   'diabetes-hbp-medication' => 'diabetes#hbp_medication'
  post  'diabetes-hbp-medication' => 'diabetes#hbp_medication'

  get   'diabetes-fruit-and-veg' => 'diabetes#fruit_and_veg'
  post  'diabetes-fruit-and-veg' => 'diabetes#fruit_and_veg'

  get   'diabetes-physical-activity' => 'diabetes#physical_activity'
  post  'diabetes-physical-activity' => 'diabetes#physical_activity'

  get   'diabetes-waist-measurement' => 'diabetes#waist_measurement'
  post  'diabetes-waist-measurement' => 'diabetes#waist_measurement'

  ####  Physical

  get   'physical-welcome' => 'physical#welcome'

  get   'physical-work-type' => 'physical#work_type'
  post  'physical-work-type' => 'physical#work_type'

  get   'physical-activity-exercise' => 'physical#activity_exercise'
  post  'physical-activity-exercise' => 'physical#activity_exercise'
  get   'physical-activity-cycling' => 'physical#activity_cycling'
  post  'physical-activity-cycling' => 'physical#activity_cycling'
  get   'physical-activity-walking' => 'physical#activity_walking'
  post  'physical-activity-walking' => 'physical#activity_walking'
  get   'physical-activity-housework' => 'physical#activity_housework'
  post  'physical-activity-housework' => 'physical#activity_housework'
  get   'physical-activity-gardening' => 'physical#activity_gardening'
  post  'physical-activity-gardening' => 'physical#activity_gardening'

  get   'physical-walking-pace' => 'physical#walking_pace'
  post  'physical-walking-pace' => 'physical#walking_pace'

  ####  Alcohol

  get   'alcohol-welcome' => 'alcohol#welcome'

  get   'alcohol-frequency' => 'alcohol#frequency'
  post  'alcohol-frequency' => 'alcohol#frequency'

  get   'alcohol-num-drinks' => 'alcohol#num_drinks'
  post  'alcohol-num-drinks' => 'alcohol#num_drinks'

  get   'alcohol-frequency-six-or-more' => 'alcohol#frequency_six_or_more'
  post  'alcohol-frequency-six-or-more' => 'alcohol#frequency_six_or_more'


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
