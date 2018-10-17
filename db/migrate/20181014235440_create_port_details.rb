class CreatePortDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :port_details do |t|

      t.timestamps
    end
  end
end
