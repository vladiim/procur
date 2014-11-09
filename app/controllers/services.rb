Procur::App.controllers :services do
  get :index do
    render 'services/index'
  end

  get :show, map: '/services/:name' do
    @name = StringHelper.titleise(params[:name])
    # @company = Company.first
    render 'services/show'
  end

  post :create, map: '/services/from-company/:id' do
    @company = Company[params[:id]]
    service = @company.create_service(params[:service], current_user.id)
    current_user.vote_for service.id, @company.id
    # @company.vote_for service.id
    redirect @company.url
  end
end