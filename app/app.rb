require 'dotenv'

Dotenv.load

module Procur
  class App < Padrino::Application
    register CoffeeInitializer
    register ScssInitializer
    register Padrino::Mailer
    register Padrino::Helpers

    enable :sessions

    register LinkedinInitializer
  end
end
