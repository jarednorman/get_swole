Sequel.migration do
  change do
    alter_table(:users) do
      add_column :nearest_round, Integer
    end
  end
end
