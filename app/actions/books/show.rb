# frozen_string_literal: true

module Bookshelf
  module Actions
    module Books
      # NOTE: generators break existing modified files
      #
      class Show < Bookshelf::Action
        include Deps["persistence.rom"]

        params do
          required(:id).value(:integer)
        end

        def handle(request, response)
          response.format = :json
          response.body = find_book(request).to_json
        end

        def find_book(request)
          rom.relations[:books].by_pk(request.params[:id]).one!
        end
      end
    end
  end
end
