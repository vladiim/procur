Sequel.migration do
  up do
    create_table :services do
      primary_key :id
      String :name
      Text :description
    end

    create_table :votes do
      primary_key :id
      Integer :profile_id
      Integer :company_id
      Integer :service_id
    end
  end

  down do
    drop_table :services
    drop_table :votes
  end
end
