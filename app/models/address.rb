class Address < ActiveRecord::Base
  belongs_to :order

  validates :street_1, :zip, :city, presence: true
  validates :zip, numericality: true

  def full_name
    return "#{gender == 1 ? 'Herr' : 'Frau'} #{academic_title} #{first_name} #{last_name}"
  end

  def glyphicon
	return 'glyphicon glyphicon-usd' if title == 'Rechnungsadresse'
  	return 'glyphicon glyphicon-send' if title == 'Lieferadresse'
  end
end
