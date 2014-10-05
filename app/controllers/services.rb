Procur::App.controllers :services do
  get :index do
    render 'services/index'
  end

  get :show, map: '/services/:name' do
    @name = StringHelper.titleise(params[:name])
    render 'services/show'
  end
end