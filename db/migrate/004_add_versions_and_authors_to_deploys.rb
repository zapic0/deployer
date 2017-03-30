class AddVersionsAndAuthorsToDeploys < ActiveRecord::Migration
  def change
    change_table :deploys do |t|
      t.references :version
      t.references :user
    end
  end
end
