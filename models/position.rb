class Position < Sequel::Model
  many_to_one :profile
  # one_to_many :companies#, class: :Company
  one_to_one :company

  attr_accessor :company

  def self.from_linkedin(position_data, profile_id, company_class = Company)
    position = Position.first(linkedin_id: position_data.id)
    position = position || create_position(position_data, profile_id)
    position.company = company_class.from_linkedin(position_data.company, position.id)
    position
  end

  # def self.companies(positions, company_class = Company)
    # @companies = @positions.inject([]) do |companies, pos|
    #   company = company_class.where(position_id: pos.id).first
    #   company.nil? ? companies : companies << company
    # end
  # end

  private

  def self.create_position(position_data, profile_id)
    create(
      profile_id: profile_id,
      linkedin_id: position_data.id,
      is_current: position_data.is_current,
      title: position_data.title
    )
  end
end