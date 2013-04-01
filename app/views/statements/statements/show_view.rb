# -*- encoding : utf-8 -*-
module Statements
  module Statements
    class ShowView < Poirot::View

      def statement_id
        dom_id(statement)
      end

      def statement_url
        url_for(statement)
      end

      def siblings_label
        I18n.t("discuss.statements.sibling_labels.#{statement.class.name.underscore}")
      end

      def siblings_url
        "siblings_url_here"
      end

      def document
        statement.node.documents.by_preferred_language(language_preference_list).first
      end

      def title
        document.title
      end

      def text
        document.text
      end

      def echos
        statement.echo.supporter_count
      end

    end
  end
end