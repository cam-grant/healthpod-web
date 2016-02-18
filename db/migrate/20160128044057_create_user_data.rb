class CreateUserData < ActiveRecord::Migration
  def change
    create_table :user_data do |t|
      t.boolean :consent
      t.boolean :returning_user

      # Demographics
      t.string :full_name
      t.date :date_of_birth
      t.string :gender
      t.string :suburb
      t.string :country_of_birth
      t.boolean :aboriginal
      t.string :has_diabetes

      # Allergies
      t.boolean :has_allergies
      t.string :allergy_list

      # BMI
      t.decimal :weight
      t.decimal :height
      t.decimal :bmi
      t.datetime :bmi_recorded_at

      t.timestamps null: false
    end
  end
end
