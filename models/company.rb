class Company < Sequel::Model
  one_to_many :positions

  many_to_many :services, join_table: :votes
  many_to_many :voters, class: :Profile, join_table: :votes

  def self.from_linkedin(company_data)
    company = Company.first(linkedin_id: company_data.id)
    company ? company : create_company(company_data)
  end

  def create_service(name, profile_id, service_class = Service)
    service = service_class.where(name: name).first
    service = service || service_class.create_for_vote(name, id, profile_id)
  end

  def url
    "/companies/#{ id }/#{ StringHelper.urlise(name) }"
  end

  private

  def self.create_company(company_data)
    create(
      linkedin_id: company_data.id,
      industry: company_data.industry,
      name: company_data.name
    )
  end
end