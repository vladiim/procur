Sequel.migration do
  up do
    alter_table :companies do
      add_column :position_id, Integer
      add_index :position_id
    end
  end

  down do
    alter_table :companies do
      drop_column :position_id
    end
  end
end
