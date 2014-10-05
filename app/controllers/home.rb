Procur::App.controllers :home do
  get :index, map: '/' do
    render '/layouts/home'
  end
end