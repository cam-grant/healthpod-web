require 'CSV'

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

    score = 2
    risk_score = 1

    # Underweight   Below 18.5       High
    # Normal        18.5–24.9        Low                                                                                                                       Low
    # Overweight    25.0–29.9        Medium                                                                                                                    Medium
    # Obesity       30.0 and Above   High

    unless self.bmi.blank?
      case
      when self.bmi < 18.5
        score = 1
        risk_score = 3
      when self.bmi.between?(18.5, 24.9)
        score = 2
        risk_score = 1
      when self.bmi.between?(25, 29.9)
        score = 3
        risk_score = 2
      else # 30.0 and Above
        score = 4
        risk_score = 3
      end
    end

    self.update_attributes bmi_score: score, bmi_risk_score: risk_score
  end

  def bmi_score_name
    "#{self.bmi} (#{lookup(UserData::BMI_SCORES, self.bmi_score, :name, "")})"
  end

  def basic_complete?
    !self.bmi_risk_score.blank?
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

    risk_score = 1
    case score
    when nil
      risk_score = 1
    when 1
      risk_score = 3
    when 2, 3
      risk_score = 2
    when 4
      risk_score = 1
    end

    self.update_attributes physical_score: score, physical_risk_score: risk_score

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

    risk_score = 1
    case
    when score.between?(4, 7)
      risk_score = 2
    when score >= 8
      risk_score = 3
    end

    self.update_attributes alcohol_score: score, alcohol_risk_score: risk_score
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

    risk_score = 1
    case
    when score.between?(6, 11)
      risk_score = 2
    when score >= 11
      risk_score = 3
    end

    self.update_attributes diabetes_score: score, diabetes_risk_score: risk_score
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

  CSV_HEADER = [
    "ID",
    "Date",
    "Name",
    "Date of birth",
    "Gender",
    "Surburb",
    "Country of birth",
    "Aboriginal",
    "Has diabetes",
    "Smoking",
    "Allergies",
    "Other allergies",
    "Weight",
    "Height",
    "BMI",
    "BMI score",

    "Alcohol frequency",
    "Alcohol no. drinks",
    "Alcohol frequency 6 or more",
    "Alcohol score",

    "Physical work type",
    "Physical activity exercise",
    "Physical activity cycling",
    "Physical activity walking",
    "Physical activity housework",
    "Physical activity gardening",
    "Physical walking pace",
    "Physical score",

    "Age group",
    "Diabetes hereditary",
    "Diagnosed with high blood glucose",
    "Takes HBP medication",
    "Daily fruit and veg",
    "Daily physical activity",
    "Waist measurement",
    "Diabetes score"
  ]

  def csv_data
    [
      id,
      created_at,
      full_name,
      date_of_birth,
      lookup(UserData::GENDERS, gender, :name),
      suburb,
      lookup(UserData::REGIONS, country_of_birth, :name),
      aboriginal,
      lookup(UserData::DIABETES, has_diabetes, :name),
      lookup(UserData::SMOKING, smoking, :name),
      allergies,
      other_allergies,
      weight,
      height,
      bmi,
      lookup(UserData::BMI_SCORES, bmi_score, :name),

      # Alcohol
      lookup(UserData::ALCOHOL_FREQUENCY, alcohol_frequency, :name),
      lookup(UserData::ALCOHOL_NUM_DRINKS, alcohol_num_drinks, :name),
      lookup(UserData::ALCOHOL_FREQUENCY_SIX_OR_MORE, alcohol_frequency_six_or_more, :name),
      alcohol_score_name,

      # Physical
      lookup(UserData::PHYSICAL_WORK_TYPES, physical_work_type, :name),
      lookup(UserData::PHYSICAL_AMOUNTS, physical_activity_exercise, :name),
      lookup(UserData::PHYSICAL_AMOUNTS, physical_activity_cycling, :name),
      lookup(UserData::PHYSICAL_AMOUNTS, physical_activity_walking, :name),
      lookup(UserData::PHYSICAL_AMOUNTS, physical_activity_housework, :name),
      lookup(UserData::PHYSICAL_AMOUNTS, physical_activity_gardening, :name),
      lookup(UserData::PHYSICAL_WALKING_PACES, physical_walking_pace, :name),
      physical_score_name,

      # Diabetes
      lookup(UserData::AGE_GROUPS, diabetes_age_group, :name),
      diabetes_hereditary,
      diabetes_high_blood_glucose,
      diabetes_hbp_medication,
      lookup(UserData::FRUIT_AND_VEG_CONSUMPTION, diabetes_fruit_and_veg, :name),
      diabetes_physical_activity,
      diabetes_waist_measurement,
      diabetes_score_name

    ]
  end

  def self.date_range_to_csv(start_date, end_date, include_header = true)
    records = UserData.where(created_at: start_date.beginning_of_day..end_date.end_of_day, consent: true)

    CSV.generate(headers: include_header) do |csv|
      csv << CSV_HEADER if include_header
      records.each do |record|
        csv << record.csv_data
      end
    end
  end

  def to_csv(include_header = true)
    CSV.generate(headers: include_header) do |csv|
      csv << CSV_HEADER if include_header
      csv << self.csv_data
    end
  end

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

  BMI_SCORES = [
    {id: 1, name: "Underweight",
      so_what: "You are underweight for your height. Unless you are naturally very slim, you may need to consider ways of gaining weight to bring your BMI to between 18.5 and 24.9.",
      what_now: "To achieve and maintain a healthy weight, be physically active every day and choose a variety of healthy foods to meet your energy needs. If you're concerned about your weight we recommend you discuss this result with your GP."
    },
    {id: 2, name: "Healthy weight",
      so_what: "Your BMI is currently within a healthy weight range. Being a healthy weight has important benefits, not only on how you feel, but also to help reduce your risk of heart disease, diabetes and a range of other conditions.",
      what_now: "To maintain a healthy weight, be physically active every day and choose a variety of healthy foods to meet your energy needs."
    },
    {id: 3, name: "Overweight",
      so_what: "Being overweight increases your risk of developing coronary heart disease, as well as other health conditions such as diabetes. ",
      what_now: "To achieve and maintain a healthy weight be physically active every day and choose a variety of healthy foods to meet your energy needs. For further advice we recommend you discuss this result with your GP."
    },
    {id: 4, name: "Obese",
      so_what: "As your BMI increases, your risk of developing coronary heart disease, diabetes and some cancers increases.",
      what_now: "It is important that you take steps to reduce your weight. The good news is even losing small amounts of weight can benefit your health. We recommend you discuss this result with your GP."
    }
  ]

  PHYSICAL_SCORES = [
    {id: 1, name: "Inactive",
      so_what: "Maintaining regular physical activity can help prevent excess weight gain and prevent or manage a wide range of health problems and concerns.",
      what_now: "Doing any physical activity is better than doing none no matter your age, weight, health problems or abilities. Start by doing some physical activity that is easily manageable and gradually build up. Discuss with your doctor if you have any concerns."
    },
    {id: 2, name: "Moderately inactive",
      so_what: "Maintaining regular physical activity can help prevent excess weight gain and prevent or manage a wide range of health problems and concerns.",
      what_now: "Try to be active on most, preferably all days of the week. Remember to minimise the amount of time spent in prolonged sitting. Break up long periods of sitting as often as possible."
    },
    {id: 3, name: "Moderately active",
      so_what: "Maintaining regular physical activity can help prevent excess weight gain and prevent or manage a wide range of health problems and concerns.",
      what_now: "Try to be active on most, preferably all days of the week. Remember to minimise the amount of time spent in prolonged sitting. Break up long periods of sitting as often as possible."
    },
    {id: 4, name: "Active",
      so_what: "Maintaining regular physical activity can help prevent excess weight gain and prevent or manage a wide range of health problems and concerns.",
      what_now: "Even though you are classified as active remember to minimise the amount of time spent in prolonged sitting. Break up long periods of sitting as often as possible."
    }
  ]

  DIABETES_SCORES = [
    {id: 1, name: "5 or less",
      so_what: "Diabetes is a chronic condition marked by high levels of glucose in the blood. If it isn’t treated it can lead to a number of serious health problems.",
      what_now: "Keep up the good work! Maintaining healthy habits is worth the effort. Managing your weight, exercising regularly and eating a balanced, healthy diet will help to maintain or reduce your risk of diabetes."
    },
    {id: 2, name: "6 - 11",
      so_what: "Diabetes is a chronic condition marked by high levels of glucose in the blood. If it isn’t treated it can lead to a number of serious health problems.",
      what_now: "There are a number of ways to help reduce the risk of type two diabetes. Managing your weight, exercising regularly and eating a balanced healthy diet are key to reducing your risk. We recommend you discuss this result with your GP."
    },
    {id: 3, name: "12 or more",
      so_what: "Diabetes is a chronic condition marked by high levels of glucose in the blood. If it isn’t treated it can lead to a number of serious health problems.",
      what_now: "We recommend you discuss this result with your GP. There are many services out there to help you make small changes to your health to have a big impact on reducing your risk of diabetes."
    },
  ]

  ALCOHOL_SCORES = [
    {id: 1, name: "Safe",
      so_what: "Keeping an eye on what you drink can have a positive effect on your health and wellbeing.",
      what_now: "Low alcohol consumption in line with recommendations is part of a balanced healthy diet. Keep up the good work!"
    },
    {id: 2, name: "Unsafe",
      so_what: "Regular drinking to excess is likely to cause problems both in the short term and the long term. In the short term cutting back on alcohol can help improve your sleep patterns, reduce stress and avoid hangovers. In the long term cutting back on alcohol can help you reduce the risk of heart disease, diabetes and some cancers.",
      what_now: "You should consider reducing your alcohol consumption. We recommend you discuss this result with your GP. Note there are no safe levels of drinking for pregnant women."
    },
    {id: 3, name: "Unsafe",
      so_what: "Regular drinking to excess is likely to cause problems both in the short term and the long term. In the short term cutting back on alcohol can help improve your sleep patterns, reduce stress and avoid hangovers. In the long term cutting back on alcohol can help you reduce the risk of heart disease, diabetes and some cancers.",
      what_now: "You should consider reducing your alcohol consumption. We recommend you discuss this result with your GP. Note there are no safe levels of drinking for pregnant women."
    },
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
