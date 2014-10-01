Procur::App.controllers :companies do
  get :show, map: '/companies/:name' do
    @name = params[:name]
    render 'companies/show'
  end
end