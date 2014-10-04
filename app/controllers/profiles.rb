Procur::App.controllers :profiles do
  get :show, map: '/profiles/:id/:name' do
    @name = StringHelper.camelise(params[:name])
    render 'profiles/show'
  end
end