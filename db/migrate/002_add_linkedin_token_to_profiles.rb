Sequel.migration do
  up do
    alter_table :profiles do
      add_column :linkedin_token, String
      add_index :linkedin_token
    end
  end

  down do
    alter_table :profiles do
      drop_column :linkedin_token
    end
  end
end
