RACK_ENV = 'test'
require 'rspec'
require 'ostruct'

module Sequel
  class Model

    def self.create(*args)
      new(*args)
    end

    attr_accessor :values
    def initialize(*args)
      @values = args[0]
    end
  end

  def one_to_many(*args)
  end
end

# require File.expand_path(File.dirname(__FILE__) + "/../config/boot")
# Dir[File.expand_path(File.dirname(__FILE__) + "/../app/helpers/**/*.rb")].each(&method(:require))

# RSpec.configure do |conf|
#   conf.include Rack::Test::Methods
# end

# You can use this method to custom specify a Rack app
# you want rack-test to invoke:
#
#   app Procur::App
#   app Procur::App.tap { |a| }
#   app(Procur::App) do
#     set :foo, :bar
#   end
#
# def app(app = nil, &blk)
#   @app ||= block_given? ? app.instance_eval(&blk) : app
#   @app ||= Padrino.application
# end
