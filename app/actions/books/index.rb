module Bookshelf
  module Actions
    module Books
      class Index < Bookshelf::Action
        include Deps["persistence.rom"]

        # TODO how does it know that it should validate params in this case?
        # How to extract this validation logic and reuse it in Hanami?

        params do
          optional(:page).value(:integer, gt?: 0)
          optional(:per_page).value(:integer, gt?: 0, lteq?: 100)
        end

        def handle(request, response)
          unless request.params.valid?
            halt 422, { errors: request.params.errors }.to_json
          end

          response.format = :json
          response.body =
            rom.relations[:books]
            .select(:title, :author)
            .order(:title)
            .page(request.params[:page] || 1)
            .per_page(request.params[:per_page] || 5)
            .to_a
            .to_json
        end
      end
    end
  end
end
