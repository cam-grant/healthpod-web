class UserData < ActiveRecord::Base

  def female?
    self.gender && self.gender.downcase == "female" ? true : false
  end

  def to_csv
    attributes = %w{full_name dob}

    CSV.generate(headers: true) do |csv|
      csv << attributes
      csv << attributes.map{ |attr| self.send(attr) }
    end
  end

end
