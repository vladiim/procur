class Vote < Sequel::Model
  # belongs_to :service, :company, :profile
  many_to_many :services
end