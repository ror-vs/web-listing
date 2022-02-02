class Deal < ApplicationRecord

  belongs_to :site
  self.inheritance_column = :_type_disabled
end