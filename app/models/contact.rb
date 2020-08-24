class Contact < ApplicationRecord
	belongs_to :contactable, polymorphic: true
	enum alias: { ing: 0, lic: 1, sr: 2, sra: 3 }
	validates :name, :last_name, :mobile_phone, presence: true
	has_rich_text :comments

	def full_name
		"#{self.alias.present? ? self.alias + '.' : ''} #{name} #{last_name}"
	end
end