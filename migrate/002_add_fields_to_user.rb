Sequel.migration do
  change do
    alter_table(:users) do
      add_column :email, String
      add_column :hashed_password, String
    end
  end
end
