class Profile < Sequel::Model

  def self.new_from_linkedin(client)
    profile_data = client.profile
    new(
      name: profile_data.first_name,
      surname: profile_data.last_name,
      headline: profile_data.headline,
      linkedin_url: profile_data.site_standard_profile_request.url,
      created_at: Time.now
    )
  end

  def url
    "/profiles/#{ id }/#{ StringHelper.urlise(name) }-#{ StringHelper.urlise(surname) }"
  end

  def fullname
    "#{ StringHelper.camelise(name) } #{ StringHelper.camelise(surname) }"
  end
end