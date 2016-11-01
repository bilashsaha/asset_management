class Sanchaypatra < ActiveRecord::Base
  belongs_to :user
  has_many :tokens
  
  def generate_tokens
    redeem_dates = []
    redeem_months = ((self.active_date) .. self.expire_date).map{|d| [d.year, d.month]}.uniq
    redeem_months = redeem_months.drop(1)
    redeem_months.each do |year,month|
      if Date.valid_date?(year,month,self.active_date.day)
        redeem_dates << Date.new(year,month,self.active_date.day)
      else
        redeem_dates << Date.new(year,month,1).next_month
      end
    end
    associated_tokens = []
    redeem_dates = redeem_dates.every_nth(self.interval_month)
    redeem_dates.each_with_index do |date,index| # 1 day added to avoid the first date
      token = Token.new
      token.token_number = index+1
      token.token_date = date
      associated_tokens << token
    end
    self.tokens = associated_tokens
  end

end
