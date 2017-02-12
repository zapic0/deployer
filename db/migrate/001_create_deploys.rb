class CreateDeploys < ActiveRecord::Migration
  def change
    create_table :deploys do |t|
      t.column :deploy_name, :string, :null => false

      t.references :project

      t.column :date, :date, :null => false
      t.column :start_time, :string,  :limit => 255, :null => false
      t.column :estimated_end_time, :integer, :default => 1, :null => false

      t.column :release_notes, :string
      t.column :affected_projects, :string
      t.column :authorization, :string
    end

    add_index :deploys, :id, :name => :deploys_list_id
  end
end
