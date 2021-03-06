class Service < Sequel::Model
  many_to_many :companies, join_table: :votes
  many_to_many :voters, class: :Profile, join_table: :votes

  def self.create_for_vote(name, company_id, profile_id, vote_class = Vote)
    service = create(name: name)
    vote = vote_class.create(
      service_id: service.id,
      company_id: company_id,
      profile_id: profile_id)
    service
  end

  def vote_count(vote_class = Vote)
    vote_class.group_and_count(:service_id).
      where(service_id: id).
      all.count
  end
end