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

    helpers do
      def login?
        !session[:atoken].nil?
      end

      def profile
        linkedin_client.profile unless session[:atoken].nil?
      end

      def current_user=(user)
        @current_user = user
      end

      def current_user
        @current_user ||= Profile[session[:current_user_id]]
      end

      def current_user?(user)
        user == current_user
      end

      def connections
        linkedin_client.connections unless session[:atoken].nil?
      end

      # private
      def linkedin_client
        client = LinkedIn::Client.new(settings.api, settings.secret)
        client.authorize_from_access(session[:atoken], session[:asecret])
        client
      end
    end
  end
end
