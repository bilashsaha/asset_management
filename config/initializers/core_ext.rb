module Enumerable
  def every_nth(n)
    (n - 1).step(self.size - 1, n).map { |i| self[i] }
  end
end