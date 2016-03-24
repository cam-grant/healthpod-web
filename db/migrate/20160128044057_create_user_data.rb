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

      # Demographics
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

    end
  end
end
