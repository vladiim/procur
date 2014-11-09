Sequel.migration do
  up do
    create_table :services do
      primary_key :id
      String :name, null: false
      Text :description
    end

    create_table :votes do
      primary_key :id
      Integer :profile_id, null: false
      Integer :company_id, null: false
      Integer :service_id, null: false
    end
  end

  down do
    drop_table :services
    drop_table :votes
  end
end
