Procur::App.controllers :companies do
  get :index do
    render 'companies/index'
  end

  get :show, map: '/companies/:id/:name' do
    @name = StringHelper.titleise(params[:name])
    render 'companies/show'
  end

  get :new, map: '/companies/new' do
    render 'companies/new'
  end
end