Procur::App.controllers :services do
  get :index do
    render 'services/index'
  end

  get :show, map: '/services/:name' do
    # @name = StringHelper.titleise(params[:name])
    @company = Company.first
    render 'services/show'
  end

  post :create, map: '/services/from-company/:id' do
    @company = Company[params[:id]]
    @company.create_service(params[:service], current_user.id)
    redirect @company.url
  end
end