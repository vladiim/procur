module LinkedinInitializer
  def self.registered(app)
    app.set :api, ENV['API_KEY']
    app.set :secret, ENV['SECRET_KEY']
  end
end