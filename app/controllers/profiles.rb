Procur::App.controllers :profiles do
  get :show, map: '/profiles/:id/:name' do
    @profile = Profile[params[:id]]
    render 'profiles/show'
  end
end