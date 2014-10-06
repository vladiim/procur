Sequel.migration do
  up do
    create_table :profiles do
      primary_key :id
      String :name
      String :surname
      String :email
      String :headline
      String :linkedin_url
      Time :created_at
    end
  end

  down do
    drop_table :profiles
  end
end