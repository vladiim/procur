Procur::App.controllers :companies do
  get :index do
    render 'companies/index'
  end

  get :show, map: '/companies/:id/:name' do
    @company = Company[params[:id]]
    # TODO: UPDATE CO DATA, company_data = client.company(id: position.id, fields: %w{ id name industry locations:(address:(city state country-code) is-headquarters) employee-count-range })
    render 'companies/show'
  end

  get :new, map: '/companies/new' do
    render 'companies/new'
  end
end