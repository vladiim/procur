Procur::App.controllers :services do
  get :show, map: '/services/:name' do
    @name = params[:name]
    render 'services/show'
  end
end