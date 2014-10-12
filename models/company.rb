# class Company < Sequel::Model
#   def self.from_linkedin(client)
#     user = client.profile(fields: ['positions'])
#     all_positions = user.positions.all

#     # figure out code & tests to ensure duplicate companies aren't created!

#     # old_companies = existing_companies(all_positions)
#     # old_company_ids = old_companies.map { |company| company.linkedin_id }
#     # new_positions = all_positions.reject { |position| old_company_ids.include?(position.company.id) }

#     # require 'debugger'; debugger

#     # return old_companies if new_positions.empty?

#     # new_companies = create_new_companies(new_positions)
#     # old_companies.concat(new_companies)
#   end

#   private

#   def self.create_new_companies(positions)
#     positions.inject([]) do |companies, position|
#       company = position.company
#       companies << create(
#         linkedin_id: company.id,
#         industry: company.industry,
#         name: company.name
#       )
#     end
#   end

#   def self.existing_companies(all_positions)
#     Company.filter(linkedin_id: all_positions.map { |position| position.company.id }).all
#   end
# end