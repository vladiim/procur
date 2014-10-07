class Profile < Sequel::Model

  def self.from_linkedin(client)
    profile = Profile.first(linkedin_token: client.consumer_token)
    profile ? profile : new_profile(client.profile, client.consumer_token)
  end

  def url
    "/profiles/#{ id }/#{ StringHelper.urlise(name) }-#{ StringHelper.urlise(surname) }"
  end

  def fullname
    "#{ StringHelper.camelise(name) } #{ StringHelper.camelise(surname) }"
  end

  private

  def self.new_profile(profile_data, token)
    # client.picture_urls
    new(
      name: profile_data.first_name,
      surname: profile_data.last_name,
      headline: profile_data.headline,
      linkedin_url: profile_data.site_standard_profile_request.url,
      linkedin_token: token,
      created_at: Time.now
    )
  end
end