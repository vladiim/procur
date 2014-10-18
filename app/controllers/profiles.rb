Procur::App.controllers :profiles do
  get :show, map: '/profiles/:id/:name' do
    @profile = Profile[params[:id]]
    @positions = @profile.positions
    @companies = Position.companies(@positions)
    render 'profiles/show'
  end
end