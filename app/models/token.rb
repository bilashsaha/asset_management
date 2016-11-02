class Token < ActiveRecord::Base
  belongs_to :sanchaypatra

  scope :redeemed, -> { where(is_redeemed: true) }
  scope :not_redeemed, -> { where(is_redeemed: false) }
  scope :till_date, -> (to_date) { where("token_date < ?",to_date) }



end
