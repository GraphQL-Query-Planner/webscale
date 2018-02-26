require 'active_record'

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  # connection established by default
end
