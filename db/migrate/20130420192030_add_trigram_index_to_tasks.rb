class AddTrigramIndexToTasks < ActiveRecord::Migration
  def up
    execute "CREATE INDEX trgm_idx ON tasks USING gist (name gist_trgm_ops);"
  end

  def down
    execute "DROP INDEX trgm_idx"
  end
end
