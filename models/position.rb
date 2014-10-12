class Position < Sequel::Model
  def self.from_linkedin(position_data)
    position = Position.first(linkedin_id: position_data.id)
    position ? position : create_position(position_data)
  end

  private

  def self.create_position(position_data)
    create(
      linkedin_id: position_data.id,
      is_current: position_data.is_current,
      title: position_data.title
    )
  end
end