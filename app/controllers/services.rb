Procur::App.controllers :services do
  get :show, map: '/services/:name' do
    @name = StringHelper.titlelise(params[:name])
    render 'services/show'
  end
end