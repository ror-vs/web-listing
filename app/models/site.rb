class Site < ApplicationRecord

  has_many :deals, dependent: :destroy
  has_many :deal_history, dependent: :destroy

end