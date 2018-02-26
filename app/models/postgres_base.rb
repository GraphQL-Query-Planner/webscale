require 'active_record'

class PostgresBase < ActiveRecord::Base
  self.abstract_class = true

  establish_connection DB_POSTGRES
end
