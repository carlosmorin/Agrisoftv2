class GeneralInformation < ApplicationRecord
	self.table_name = 'general_information'
  
  belongs_to :user_id
end
