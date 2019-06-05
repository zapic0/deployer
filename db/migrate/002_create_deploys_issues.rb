class CreateDeploysIssues < ActiveRecord::Migration[4.2]
  def change
    create_table :deploys_issues do |t|
      t.references :deploy, :issue
    end

    add_index :deploys_issues, [:deploy_id, :issue_id]
  end
end
