Rails.application.routes.draw do

  ####  Welcome / hub

  root  'welcome#welcome'

  get   'consent' => 'welcome#consent'
  post  'consent' => 'welcome#consent'

  get   'hub' => 'welcome#hub'

  get   'print' => 'welcome#print'

  get   'follow-up' => 'welcome#follow_up'
  post  'follow-up' => 'welcome#follow_up'

  # Returning user

  get   'returning-user' => 'welcome#returning_user'
  post  'returning-user' => 'welcome#returning_user'

  get   'returning-user-q1' => 'welcome#returning_user_q1'
  post  'returning-user-q1' => 'welcome#returning_user_q1'

  get   'returning-user-q2' => 'welcome#returning_user_q2'
  post  'returning-user-q2' => 'welcome#returning_user_q2'

  get   'returning-user-q3' => 'welcome#returning_user_q3'
  post  'returning-user-q3' => 'welcome#returning_user_q3'

  get   'returning-user-q4' => 'welcome#returning_user_q4'
  post  'returning-user-q4' => 'welcome#returning_user_q4'

  get   'returning-user-q5' => 'welcome#returning_user_q5'
  post  'returning-user-q5' => 'welcome#returning_user_q5'

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

  #### Data export

  get   'data' => 'data#index'
  post  'data-practice' => 'data#practice_export'
  post  'data-research' => 'data#research_export'

end
