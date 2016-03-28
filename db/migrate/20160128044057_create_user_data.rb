class CreateUserData < ActiveRecord::Migration
  def change
    create_table :user_data do |t|
      t.boolean :consent
      t.boolean :returning_user
      t.timestamps null: false

      # Survey status
      t.boolean :basic_complete
      t.boolean :diabetes_complete
      t.boolean :physical_complete
      t.boolean :alcohol_complete

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
      t.string :other_allergies

      # BMI
      t.decimal :weight
      t.decimal :height
      t.decimal :bmi
      t.datetime :bmi_recorded_at

      # Alcohol
      t.integer :alcohol_frequency
      t.integer :alcohol_num_drinks
      t.integer :alcohol_frequency_six_or_more
      t.integer :alcohol_score

      # Physical
      t.integer :physical_work_type
      t.integer :physical_activity_exercise
      t.integer :physical_activity_cycling
      #t.integer :physical_activity_walking
      #t.integer :physical_activity_housework
      #t.integer :physical_activity_gardening
      #t.integer :physical_walking_pace
      t.integer :physical_score

      # Diabetes
      t.integer :diabetes_age_group
      t.boolean :diabetes_hereditary
      t.boolean :diabetes_high_blood_glucose
      t.boolean :diabetes_hbp_medication
      t.integer :diabetes_fruit_and_veg
      t.boolean :diabetes_physical_activity
      t.integer :diabetes_waist_measurement
      t.integer :diabetes_score

    end
  end
end
