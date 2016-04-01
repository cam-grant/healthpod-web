class CreateUserData < ActiveRecord::Migration
  def change
    create_table :user_data do |t|
      t.boolean :consent
      t.timestamps null: false

      # Returing user
      t.boolean :returning_user
      t.integer :returning_user_q1a # The Health Pod was easy to use.
      t.integer :returning_user_q1b # I would like to use the Health Pod frequently.
      t.integer :returning_user_q1c # I felt very confident using the Health Pod.
      t.integer :returning_user_q1d # The Health Pod increased my awareness of my health.
      t.integer :returning_user_q1e # The health report card provided useful information.
      t.string  :returning_user_q2  # Did you discuss any health issues identified on your health report card with your GP, nurse, friends or family?
      t.string  :returning_user_q3  # Did you do any of the following after using the Health Pod?
      t.string  :returning_user_q4  # Other action taken after using the pod
      t.boolean :returning_user_q5  # Did you visit the website shown on your health report card?

      # Basic health
      t.string :full_name
      t.date :date_of_birth
      t.integer :gender
      t.string :suburb
      t.integer :country_of_birth
      t.boolean :aboriginal
      t.integer :has_diabetes
      t.integer :smoking

      # Allergies
      t.string :allergies
      t.string :other_allergiesx

      # BMI
      t.decimal :weight
      t.decimal :height
      t.decimal :bmi
      t.datetime :bmi_recorded_at

      t.integer :basic_risk_score

      # Alcohol
      t.integer :alcohol_frequency
      t.integer :alcohol_num_drinks
      t.integer :alcohol_frequency_six_or_more
      t.integer :alcohol_score
      t.integer :alcohol_risk_score

      # Physical
      t.integer :physical_work_type
      t.integer :physical_activity_exercise
      t.integer :physical_activity_cycling
      t.integer :physical_activity_walking
      t.integer :physical_activity_housework
      t.integer :physical_activity_gardening
      t.integer :physical_walking_pace
      t.integer :physical_score
      t.integer :physical_risk_score

      # Diabetes
      t.integer :diabetes_age_group
      t.boolean :diabetes_hereditary
      t.boolean :diabetes_high_blood_glucose
      t.boolean :diabetes_hbp_medication
      t.integer :diabetes_fruit_and_veg
      t.boolean :diabetes_physical_activity
      t.integer :diabetes_waist_measurement
      t.integer :diabetes_score
      t.integer :diabetes_risk_score

    end
  end
end
