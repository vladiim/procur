require 'dotenv'

Dotenv.load

module Procur
  class App < Padrino::Application
    register ScssInitializer
    register Padrino::Mailer
    register Padrino::Helpers

    enable :sessions

    get '/' do
      render '/layouts/home'
    end
  end
end
