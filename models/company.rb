class Company < Sequel::Model
  def self.from_linkedin(client)
    user = client.profile(fields: ['positions'])
    user.positions.all.inject([]) do |companies, company|
      companies << new(
        linkedin_id: company.id,
        industry: company.industry,
        name: company.name
      )
    end
  end
end