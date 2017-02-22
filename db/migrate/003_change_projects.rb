class ChangeProjects < ActiveRecord::Migration
  def change
    change_table :projects do |t|
      t.column :customers_deploys_notifications_emails, :string
      t.column :deploys_notifications_emails, :string
      t.column :abbreviation, :string
    end
  end
end