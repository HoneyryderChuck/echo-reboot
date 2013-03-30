# -*- encoding : utf-8 -*-
require 'sinatra'
require 'sinatra/json'
module Api
  class Statement < Sinatra::Base
    STATEMENT_TYPES = /questions|proposals|improvements|pro_arguments|contra_arguments|background_infos/

    before %r{(#{STATEMENT_TYPES})\/(\d+)} do
      klass, id = params[:captures]
      begin
        @statement = klass.singularize.classify.constantize.find(id)
      rescue ActiveRecord::RecordNotFound
        raise Sinatra::NotFound
      end
    end
    
    get %r{(#{STATEMENT_TYPES})\/(\d+)} do
      raise Sinatra::NotFound unless @statement.node.published?
      attributes = {
        # statement relevant information
        id: id, creator: @statement.creator.profile.full_name, echos: @statement.echo.supporter_count,
        # node relevant information
        image_url: @statement.node.statement_image.url, topics: @statement.node.topics
      }
      # getting the right document
      document = @statement.node.current_document(I18n.locale) || @statement.node.current_document(I18n.default_locale)
      attributes.merge!(title: document.title, text: document.text)

      attributes[:external_url] = @statement.external_url if @statement.is_a?(BackgroundInfo)

      json attributes
    end

  end
end