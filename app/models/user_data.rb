class UserData < ActiveRecord::Base

  PHYSICAL_SURVEY_ESTIMATE = "1 minute"
  DIABETES_SURVEY_ESTIMATE = "1 minute"
  ALCOHOL_SURVEY_ESTIMATE = "30 seconds"

  def male?
    self.gender && self.gender == 1 ? true : false
  end

  def female?
    self.gender && self.gender == 2 ? true : false
  end

  def returning_user_took_other_steps?
    self.returning_user_q3 && self.returning_user_q3.include?("Other") ? true : false
  end

  def has_other_allergies?
    self.allergies && self.allergies.include?("Other") ? true : false
  end

  def has_diabetes?
    self.has_diabetes && self.has_diabetes == 1 ? true : false
  end

  def born_in_asia?
    self.country_of_birth && self.country_of_birth == 2
  end

  def asian_or_aboriginal?
    self.born_in_asia? || self.aboriginal
  end

  def smokes?
    self.smoking && self.smoking == 3
  end

  def non_drinker?
    self.alcohol_frequency && self.alcohol_frequency == 1
  end

  def calc_basic_score
    self.update_attributes basic_risk_score: 2
  end

  def basic_complete?
    !self.basic_risk_score.blank?
  end

  def calc_physical_score
    return unless self.physical_work_type && self.physical_activity_exercise

    total_exercise = (self.physical_activity_exercise > self.physical_activity_cycling) ? self.physical_activity_exercise : self.physical_activity_cycling
    score = 1

    case self.physical_work_type
    when 1, 2 # Not employed or sedentry
      score = total_exercise

    when 3 # Standing
      score = total_exercise + 1

    when 4 # Physical
      score = total_exercise + 2

    when 5 # Heavy manual
      score = total_exercise + 3

    end

    score = 4 if score > 4
    self.update_attributes physical_score: score, physical_risk_score: 1

  end

  def physical_complete?
    !self.physical_risk_score.blank?
  end

  def physical_score_name
    lookup UserData::PHYSICAL_SCORES, self.physical_score, :name, ""
  end

  def calc_alcohol_score
    score = 0
    score += lookup(UserData::ALCOHOL_FREQUENCY, self.alcohol_frequency, :value, 0)
    score += lookup(UserData::ALCOHOL_NUM_DRINKS, self.alcohol_num_drinks, :value, 0)
    score += lookup(UserData::ALCOHOL_FREQUENCY_SIX_OR_MORE, self.alcohol_frequency_six_or_more, :value, 0)

    self.update_attributes alcohol_score: score, alcohol_risk_score: 1
  end

  def alcohol_complete?
    !self.alcohol_risk_score.blank?
  end

  def alcohol_score_name
    (self.alcohol_score && self.alcohol_score >= 4) ? "Unsafe" : "Safe"
  end

  def calc_diabetes_score
    score = 0
    score += lookup(UserData::AGE_GROUPS, self.diabetes_age_group, :value, 0)
    score += 3 if self.male?
    score += 2 if self.aboriginal
    score += 2 if self.born_in_asia?
    score += 3 if self.diabetes_hereditary
    score += 6 if self.diabetes_high_blood_glucose
    score += 2 if self.diabetes_hbp_medication
    score += 2 if self.smokes?
    score += 1 if (self.diabetes_fruit_and_veg && self.diabetes_fruit_and_veg == 2)
    score += 2 unless self.diabetes_physical_activity

    if self.asian_or_aboriginal? && self.male?
      score += waist_size_score(self.diabetes_waist_measurement, 90, 100)
    elsif self.asian_or_aboriginal? && self.female?
      score += waist_size_score(self.diabetes_waist_measurement, 80, 90)
    elsif self.female?
      score += waist_size_score(self.diabetes_waist_measurement, 88, 100)
    else # male
      score += waist_size_score(self.diabetes_waist_measurement, 102, 110)
    end

    self.update_attributes diabetes_score: score, diabetes_risk_score: 2
  end

  def diabetes_complete?
    !self.diabetes_risk_score.blank?
  end

  def waist_size_score(waist_size, lower_bound, upper_bound)
    return 0 if waist_size.blank?
    case
    when waist_size < lower_bound
      return 0
    when waist_size.between?(lower_bound, upper_bound)
      return 4
    when waist_size > upper_bound
      return 7
    end
  end

  def diabetes_score_name
    case self.diabetes_score
    when nil, 0..5
      "Low risk"
    when 6..11
      "Intermediate risk"
    else
      "High risk"
    end
  end

  def lookup(list, id, attr = :name, default = nil)
    items = list.select {|i| i[:id] == id}
    items && items[0] && items[0][attr] ? items[0][attr] : default
  end

  # def to_csv
  #   attributes = %w{full_name dob}
  #
  #   CSV.generate(headers: true) do |csv|
  #     csv << attributes
  #     csv << attributes.map{ |attr| self.send(attr) }
  #   end
  # end

  LIKERT = [
    {id: 1, name: "Strongly disagree"},
    {id: 2, name: "Disagree"},
    {id: 3, name: "Neutral"},
    {id: 4, name: "Agree"},
    {id: 5, name: "Strongly agree"},
  ]

  GENDERS = [
    {id: 1, name: "Male", value: nil},
    {id: 2, name: "Female", value: nil},
    {id: 3, name: "Prefer not to answer", value: nil}
  ]

  REGIONS = [
    {id: 1, name: "Australia", value: 0},
    {id: 2, name: "Asia, including the Indian sub-continent", value: 2},
    {id: 3, name: "Middle east", value: 2},
    {id: 4, name: "North Africa", value: 2},
    {id: 5, name: "Southern Europe", value: 2},
    {id: 6, name: "Other", value: 0}
  ]

  DIABETES = [
      {id: 1, name: "Yes", value: nil},
      {id: 2, name: "Yes, but only during pregnancy", value: nil, female: true},
      {id: 3, name: "No", value: nil},
      {id: 4, name: "Don't know", value: nil}
  ]

  SMOKING = [
    {id: 1, name: "No, I have never smoked", value: nil},
    {id: 2, name: "No, but I used to smoke before", value: nil},
    {id: 3, name: "Yes", value: nil}
  ]

  FOOD_ALLERGIES = [
    "Peanuts",
    "Tree nuts",
    "Milk",
    "Egg",
    "Wheat",
    "Soy",
    "Fish",
    "Shellfish"
  ]

  DRUG_ALLERGIES = [
    "Amoxicillin",
    "Ampicillin",
    "Penicillin",
    "Tetracycline",
    "Ibuprofen", # (Advil, Motrin, Nuprin)",
    "Naproxen", # (Aleve, Anaprox)",
    "Aspirin"
  ]

  ALCOHOL_FREQUENCY = [
    {id: 1, name: "Never", value: 0},
    {id: 2, name: "Monthly", value: 1},
    {id: 3, name: "Weekly", value: 2},
    {id: 4, name: "Some days each week ", value: 3},
    {id: 5, name: "Most days each week", value: 4}
  ]

  ALCOHOL_NUM_DRINKS = [
    {id: 1, name: "1 or 2", value: 0},
    {id: 2, name: "3 or 4", value: 1},
    {id: 3, name: "5 or 6", value: 2},
    {id: 4, name: "7 or 9 ", value: 3},
    {id: 5, name: "More than 10", value: 4}
  ]

  ALCOHOL_FREQUENCY_SIX_OR_MORE = [
    {id: 1, name: "Never", value: 0},
    {id: 2, name: "Monthly", value: 1},
    {id: 3, name: "Weekly", value: 2},
    {id: 4, name: "Some days each week ", value: 3},
    {id: 5, name: "Most days each week", value: 4}
  ]

  PHYSICAL_WORK_TYPES = [
    {id: 1, name: "I am not in employment", example: "E.g. retired, retired for health reasons, unemployed, full-time carer, etc."},
    {id: 2, name: "I spend most of my time sitting at work", example: "E.g. office worker.", value: "Mostly sitting"},
    {id: 3, name: "I spend most of my time standing or walking at work", example: "E.g. shop assistant, hairdresser, security guard, childminder, etc."},
    {id: 4, name: "My work involves physical effort", example: "E.g. plumber, electrician, carpenter, cleaner, hospital nurse, gardener, etc."},
    {id: 5, name: "My work involves vigorous physical activity", example: "E.g. scaffolder, construction worker, refuse collector, etc."}
  ]

  PHYSICAL_AMOUNTS = [
    {id: 1, name: "None"},
    {id: 2, name: "Some, but less than 1 hour"},
    {id: 3, name: "Between 1 and 3 hours"},
    {id: 4, name: "3 hours or more"},
  ]

  PHYSICAL_WALKING_PACES = [
    {id: 1, name: "Slow pace (less than 5 km/h)"},
    {id: 2, name: "Steady average pace"},
    {id: 3, name: "Brisk pace"},
    {id: 4, name: "Fast pace (more than 6 km/h)"},
  ]

  PHYSICAL_SCORES = [
    {id: 1, name: "Inactive"},
    {id: 2, name: "Moderately inactive"},
    {id: 3, name: "Moderately active"},
    {id: 4, name: "Active"},
  ]

  AGE_GROUPS = [
    {id: 1, name: "Under 35 years", value: 0},
    {id: 2, name: "35 - 44 years", value: 2},
    {id: 3, name: "45 - 54 years", value: 4},
    {id: 4, name: "55 - 64 years", value: 6},
    {id: 5, name: "65 years or over", value: 8}
  ]

  FRUIT_AND_VEG_CONSUMPTION = [
    {id: 1, name: "Every day", value: 0},
    {id: 2, name: "Not every day", value: 1}
  ]

  WAIST_SIZES_WOMEN = [
    {clothing: 10, cm: 81, inches: "32"},
    {clothing: 12, cm: 87, inches: "34"},
    {clothing: 14, cm: 93, inches: "36 1/2"},
    {clothing: 16, cm: 99, inches: "39"},
    {clothing: 18, cm: 105, inches: "41 1/2"},
    {clothing: 20, cm: 111, inches: "43 1/2"},
    {clothing: 22, cm: 117, inches: "46"},
    {clothing: 24, cm: 123, inches: "48 1/2"}
  ]

  WAIST_SIZES_MEN = [
    {clothing: "S", cm: 91, inches: "36"},
    {clothing: "M", cm: 99, inches: "39"},
    {clothing: "L", cm: 107, inches: "42"},
    {clothing: "XL", cm: 115, inches: "45"},
    {clothing: "XXL", cm: 123, inches: "48 1/2"},
    {clothing: "XXXL", cm: 131, inches: "51 1/2"}
  ]

  SUBURBS = [
    "Acton",
    "Ainslie",
    "Amaroo",
    "Aranda",
    "Banks",
    "Barton",
    "Beard",
    "Belconnen",
    "Bonner",
    "Bonython",
    "Braddon",
    "Bruce",
    "Calwell",
    "Campbell",
    "Capital Hill",
    "Casey",
    "Chapman",
    "Charnwood",
    "Chifley",
    "Chisholm",
    "City",
    "Conder",
    "Cook",
    "Coombs",
    "Crace",
    "Curtin",
    "Deakin",
    "Dickson",
    "Downer",
    "Duffy",
    "Dunlop",
    "Evatt",
    "Fadden",
    "Farrer",
    "Fisher",
    "Florey",
    "Flynn",
    "Forde",
    "Forrest",
    "Franklin",
    "Fraser",
    "Fyshwick",
    "Garran",
    "Gilmore",
    "Giralang",
    "Gordon",
    "Gowrie",
    "Greenway",
    "Griffith",
    "Gungahlin",
    "Hackett",
    "Hall",
    "Harrison",
    "Hawker",
    "Higgins",
    "Holder",
    "Holt",
    "Hughes",
    "Hume",
    "Isaacs",
    "Isabella Plains",
    "Jacka",
    "Kaleen",
    "Kambah",
    "Kingston",
    "Latham",
    "Lawson",
    "Lyneham",
    "Lyons",
    "Macarthur",
    "Macgregor",
    "Macquarie",
    "Mawson",
    "McKellar",
    "Melba",
    "Mitchell",
    "Monash",
    "Narrabundah",
    "Ngunnawal",
    "Nicholls",
    "Oaks Estate",
    "O'Connor",
    "O'Malley",
    "Oxley",
    "Page",
    "Palmerston",
    "Parkes",
    "Pearce",
    "Phillip",
    "Pialligo",
    "Red Hill",
    "Reid",
    "Richardson",
    "Rivett",
    "Russell",
    "Scullin",
    "Spence",
    "Stirling",
    "Symonston",
    "Tharwa",
    "Theodore",
    "Torrens",
    "Turner",
    "Wanniassa",
    "Waramanga",
    "Watson",
    "Weetangera",
    "Weston",
    "Wright",
    "Yarralumla"
  ]

end
