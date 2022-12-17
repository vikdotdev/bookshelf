module Bookshelf
  module Actions
    module Home
      class Show < Bookshelf::Action
        def handle(*, response)
          response.body = "Hello from Hanami"
        end
      end
    end
  end
end
