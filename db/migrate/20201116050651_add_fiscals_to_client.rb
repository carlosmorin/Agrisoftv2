# frozen_string_literal: true

class AddFiscalsToClient < ActiveRecord::Migration[6.0]
  def change
    Client.all.each do |client|
      client.update(fiscal: true) if client.fiscals.any?
    end
  end
end
