class Residents < ApplicationRecord
    self.table_name = "residents"
    attr_accessor :first_name, :last_name
    
end
