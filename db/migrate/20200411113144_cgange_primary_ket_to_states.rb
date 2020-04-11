class CgangePrimaryKetToStates < ActiveRecord::Migration[6.0]
  def change
		query = 'ALTER TABLE states ADD PRIMARY KEY (id);'
		ActiveRecord::Base.connection.execute(query)
  end
end
