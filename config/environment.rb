# frozen_string_literal: true

# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ENV['API_URI'] = 'http://api.openweathermap.org/data/2.5/weather'
ENV['API_KEY'] = '3fc82b390a874c7c422510d5488b0722'
ENV['LOCAL_CITY'] = 'Monterrey,MX'
