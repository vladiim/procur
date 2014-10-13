class Profile < Sequel::Model

  one_to_many :positions, key: 'profile_id'

  attr_reader :positions
  def initialize(*args)
    super(*args)
    @positions = []
  end

  def self.from_linkedin(client)
    profile = Profile.first(linkedin_token: client.consumer_token)
    profile ? profile : create_profile(client.profile, client.consumer_token)
  end

  def positions_from_linkedin(client, position_class = Position)
    user = client.profile(fields: ['positions'])
    user.positions.all.each { |position| add_to_positions(position, position_class) }
    positions
  end

  def url
    "/profiles/#{ id }/#{ StringHelper.urlise(name) }-#{ StringHelper.urlise(surname) }"
  end

  def fullname
    "#{ StringHelper.camelise(name) } #{ StringHelper.camelise(surname) }"
  end

  private

  def add_to_positions(position, position_class)
    new_position = position_class.from_linkedin(position, id)
    positions.push(new_position) unless positions.include?(new_position)
  end

  def self.create_profile(profile_data, token)
    # client.picture_urls
    create(
      name: profile_data.first_name,
      surname: profile_data.last_name,
      headline: profile_data.headline,
      linkedin_url: profile_data.site_standard_profile_request.url,
      linkedin_token: token,
      created_at: Time.now
    )
  end
end