class Sanchaypatra < ActiveRecord::Base
  belongs_to :user
  has_many :tokens

end
