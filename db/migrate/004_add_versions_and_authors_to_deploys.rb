class AddVersionsAndAuthorsToDeploys < ActiveRecord::Migration[4.2]
  def change
    change_table :deploys do |t|
      t.references :version
      t.references :user
    end
  end
end
