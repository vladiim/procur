class Profile < Sequel::Model
  one_to_many :positions

  many_to_many :services, join_table: :votes
  many_to_many :companies, join_table: :votes

  def self.from_linkedin(client)
    profile = Profile.first(linkedin_token: client.consumer_token)
    return profile if profile
    email = client.profile(fields: ['email-address']).email_address
    create_profile(client.profile, client.consumer_token, email)
  end

  def positions_from_linkedin(client, position_class = Position)
    user = client.profile(fields: ['positions'])
    user.positions.all.each { |position| position_class.from_linkedin(position, id) }
    positions
  end

  def url
    "/profiles/#{ id }/#{ StringHelper.urlise(name) }-#{ StringHelper.urlise(surname) }"
  end

  def fullname
    "#{ StringHelper.camelise(name) } #{ StringHelper.camelise(surname) }"
  end

  def vote_for(service_id, company_id, vote_class = Vote)
    vote_class.create(profile_id: id,
      service_id: service_id, company_id: company_id)
  end

  private

  def self.create_profile(profile_data, token, email)
    # client.picture_urls
    create(
      name: profile_data.first_name,
      surname: profile_data.last_name,
      email: email,
      headline: profile_data.headline,
      linkedin_url: profile_data.site_standard_profile_request.url,
      linkedin_token: token,
      created_at: Time.now
    )
  end
end