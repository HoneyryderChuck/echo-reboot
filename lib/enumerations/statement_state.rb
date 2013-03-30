# -*- encoding : utf-8 -*-
class StatementState < Enumeration

  def published?
    code.eql?("published")
  end
end