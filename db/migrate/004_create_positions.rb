Sequel.migration do
  up do
    create_table :positions do
      primary_key :id
      Integer :linkedin_id, index: true
      Integer :profile_id, index: true
      String :title
      Boolean :is_current
    end
  end

  down do
    drop_table :positions
  end
end
