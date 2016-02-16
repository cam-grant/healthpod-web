class UserData < ActiveRecord::Base

  # :used_kiosk_before,
  # :full_name
  # :dob

  def to_csv
    attributes = %w{full_name dob}

    CSV.generate(headers: true) do |csv|
      csv << attributes
      csv << attributes.map{ |attr| self.send(attr) }
    end
  end

end
