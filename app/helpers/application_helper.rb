module ApplicationHelper

  def total_profit_on_collection(sanchaypatras)
    sanchaypatras.collect{|sanchaypatra| sanchaypatra.profit_per_lac.to_f * sanchaypatra.tokens.length}.sum.to_f
  end

end
