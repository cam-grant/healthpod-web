class UserData < ActiveRecord::Base

  def male?
    self.gender && self.gender == UserData::GENDERS[0][:id] ? true : false
  end

  def female?
    self.gender && self.gender == UserData::GENDERS[1][:id] ? true : false
  end

  def has_other_allergies?
    self.allergies && self.allergies.include?("Other") ? true : false
  end

  def has_diabetes?
    self.has_diabetes && self.has_diabetes == UserData::DIABETES[0][:id] ? true : false
  end

  def to_csv
    attributes = %w{full_name dob}

    CSV.generate(headers: true) do |csv|
      csv << attributes
      csv << attributes.map{ |attr| self.send(attr) }
    end
  end

  GENDERS = [
    {id: 0, name: "Male", value: nil},
    {id: 1, name: "Female", value: nil},
    {id: 2, name: "Prefer not to answer", value: nil}
  ]

  REGIONS = [
    {id: 0, name: "Australia", value: 0},
    {id: 1, name: "Asia, including the Indian sub-continent", value: 2},
    {id: 2, name: "Middle east", value: 2},
    {id: 3, name: "North Africa", value: 2},
    {id: 4, name: "Southern Europe", value: 2},
    {id: 5, name: "Other", value: 0}
  ]

  DIABETES = [
      {id: 0, name: "Yes", value: nil},
      {id: 1, name: "Yes, but only during pregnancy", value: nil, female: true},
      {id: 2, name: "No", value: nil},
      {id: 3, name: "Don't know", value: nil}
  ]

  SMOKING = [
    {id: 0, name: "No, I have never smoked", value: nil},
    {id: 1, name: "No, but I used to smoke before", value: nil},
    {id: 2, name: "Yes", value: nil}
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
    {id: 0, name: "Never", value: 0},
    {id: 1, name: "Monthly", value: 1},
    {id: 2, name: "Weekly", value: 2},
    {id: 3, name: "Some days each week ", value: 3},
    {id: 4, name: "Most days each week", value: 4}
  ]

  ALCOHOL_NUM_DRINKS = [
    {id: 0, name: "1 or 2", value: 0},
    {id: 1, name: "3 or 4", value: 1},
    {id: 2, name: "5 or 6", value: 2},
    {id: 3, name: "7 or 9 ", value: 3},
    {id: 4, name: "More than 10", value: 4}
  ]

  ALCOHOL_FREQUENCY_SIX_OR_MORE = [
    {id: 0, name: "Never", value: 0},
    {id: 1, name: "Monthly", value: 1},
    {id: 2, name: "Weekly", value: 2},
    {id: 3, name: "Some days each week ", value: 3},
    {id: 4, name: "Most days each week", value: 4}
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
