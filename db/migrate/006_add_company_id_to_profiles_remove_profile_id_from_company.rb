Sequel.migration do
  up do
    alter_table :companies do
      drop_column :position_id
    end

    alter_table :positions do
      add_column :company_id, Integer
      add_index :company_id
    end
  end

  down do
    alter_table :companies do
      add_column :position_id, Integer
      add_index :position_id
    end
    alter_table :positions do
      drop_column :company_id
    end
  end
end
