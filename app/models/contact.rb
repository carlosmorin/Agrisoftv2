class Contact < ApplicationRecord
	belongs_to :contactable, polymorphic: true
	enum alias: { ing: 0, lic: 1, sr: 2, sra: 3 }
	validates :name, :last_name, :mobile_phone, :alias, presence: true

	def full_name
		"#{self.alias.present? ? self.alias : ''} #{name} #{last_name}"
	end
end