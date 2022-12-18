# frozen_string_literal: true

require "hanami"

module Bookshelf
  class App < Hanami::App
    config.middleware.use :body_parser, :json

    environment(:test) do
      require "pry-byebug"
    end

    environment(:development) do
      require "pry-byebug"
    end
  end
end

