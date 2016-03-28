require 'test_helper'

class UserDataTest < ActiveSupport::TestCase
  test "the truth" do

    # {id: 1, name: "Male", value: nil},
    # {id: 2, name: "Female", value: nil},
    # {id: 3, name: "Prefer not to answer", value: nil}

    # AGE_GROUPS = [
    #   {id: 1, name: "Under 35 years", value: 0},
    #   {id: 2, name: "35 - 44 years", value: 2},
    #   {id: 3, name: "45 - 54 years", value: 4},
    #   {id: 4, name: "55 - 64 years", value: 6},
    #   {id: 5, name: "65 years or over", value: 8}
    # ]

    data = []

    # Male / female
    data << [1, 1, false, 1, 1, false, false, false, 1, 1, 1, 3]
    data << [2, 1, false, 1, 1, false, false, false, 1, 1, 1, 0]

    # Age groups - female
    data << [2, 1, false, 1, 1, false, false, false, 1, 1, 1, 0]
    data << [2, 1, false, 1, 2, false, false, false, 1, 1, 1, 2]
    data << [2, 1, false, 1, 3, false, false, false, 1, 1, 1, 4]
    data << [2, 1, false, 1, 4, false, false, false, 1, 1, 1, 6]
    data << [2, 1, false, 1, 5, false, false, false, 1, 1, 1, 8]
    # Age groups - male
    data << [1, 1, false, 1, 1, false, false, false, 1, 1, 1, 3]
    data << [1, 1, false, 1, 2, false, false, false, 1, 1, 1, 5]
    data << [1, 1, false, 1, 3, false, false, false, 1, 1, 1, 7]
    data << [1, 1, false, 1, 4, false, false, false, 1, 1, 1, 9]
    data << [1, 1, false, 1, 5, false, false, false, 1, 1, 1, 11]

    # Aboriginal - female
    data << [2, 1, true, 1, 1, false, false, false, 1, 1, 1, 2]
    # Aboriginal - male
    data << [1, 1, true, 1, 1, false, false, false, 1, 1, 1, 5]

    # Not asian, female
    data << [2, 1, false, 1, 1, false, false, false, 1, 1, 1, 0]
    # Asian, female
    data << [2, 2, false, 1, 1, false, false, false, 1, 1, 1, 2]
    # Asian, male
    data << [1, 2, false, 1, 1, false, false, false, 1, 1, 1, 5]
    # Asian, male, aboriginal
    data << [1, 2, true, 1, 1, false, false, false, 1, 1, 1, 7]

    # hereditary, female
    data << [2, 1, false, 1, 1, true, false, false, 1, 1, 1, 3]
    # hereditary, male
    data << [1, 1, false, 1, 1, true, false, false, 1, 1, 1, 6]
    # hereditary, male, aboriginal
    data << [1, 1, true, 1, 1, true, false, false, 1, 1, 1, 8]

    data.each_with_index do |item, i|
      u = UserData.new consent: true,
        gender: data[i][0],
        country_of_birth: data[i][1],
        aboriginal: data[i][2],
        smoking: data[i][3],
        diabetes_age_group: data[i][4],
        diabetes_hereditary: data[i][5],
        diabetes_high_blood_glucose: data[i][6],
        diabetes_hbp_medication: data[i][7],
        diabetes_fruit_and_veg: data[i][8],
        diabetes_physical_activity: data[i][9],
        diabetes_waist_measurement: data[i][10]
      u.save
      u.calc_diabetes_score

      assert u.diabetes_complete
      assert_not_nil u.diabetes_complete
      assert u.diabetes_score == data[i][11], "Score mismatch, test #{i}. Expected #{data[i][11]} got #{u.diabetes_score}"

    end

  end
end
