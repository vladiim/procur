Procur::App.controllers :companies do
  get :show, map: '/companies/:name' do
    @name = StringHelper.titlelise(params[:name])
    render 'companies/show'
  end
end