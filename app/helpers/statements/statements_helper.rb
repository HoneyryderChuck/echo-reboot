module Statements::StatementsHelper

  def supporters_number(statement)
    count = statement.new_record? ? 1 : statement.echo.supporter_count
    I18n.t("discuss.statements.echo_indicator", :supporter_count => count)
  end

end

