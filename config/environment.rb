# Load the Rails application.
require File.expand_path('../application', __FILE__)
require 'carrierwave/orm/activerecord'
require 'simplecov' if ["test", "development"].include?(Rails.env)
# Initialize the Rails application.
Rails.application.initialize!
