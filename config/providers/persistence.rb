require 'pry'

Hanami.app.register_provider :persistence, namespace: true do
  prepare do
    require "rom"

    # NOTE: target is a Bookshelf::Container
    config = ROM::Configuration.new(:sql, target["settings"].database_url)

    register "config", config
    register "db", config.gateways[:default].connection
  end

  start do
    config = target["persistence.config"]

    config.auto_registration(
      target.root.join("lib/bookshelf/persistence"),
      namespace: "Bookshelf::Persistence"
    )

    register "rom", ROM.container(config)
  end
end