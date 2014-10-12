Sequel.migration do
  up do
    create_table :companies do
      primary_key :id
      Integer :linkedin_id, index: true
      String :name
      String :industry
    end
  end

  down do
    drop_table :companies
  end
end
