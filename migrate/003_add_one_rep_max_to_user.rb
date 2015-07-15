Sequel.migration do
  change do
    alter_table(:users) do
      add_column :one_rep_max_bench, Integer
      add_column :one_rep_max_deadlift, Integer
      add_column :one_rep_max_military, Integer
      add_column :one_rep_max_squat, Integer
    end
  end
end
