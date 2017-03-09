class CreateDeploys < ActiveRecord::Migration
  def change
    create_table :deploys do |t|
      t.column :deploy_name, :string, null: false

      t.column :project, :string, null: false

      t.column :date, :date, :null => false
      t.column :start_time, :datetime, :null => false
      t.column :estimated_end_time, :datetime, :null => false

      t.column :release_notes, :string, :null => false
      t.column :affected_projects, :string
      t.column :authorization, :string

      t.column :origin, :string

      t.column :state, :string
    end

    add_index :deploys, :id, :name => :deploys_list_id
  end
end
