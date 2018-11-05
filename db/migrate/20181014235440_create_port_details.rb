# frozen_string_literal: true

class CreatePortDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :port_details do |t|
      t.string :number
      t.jsonb :details
      t.timestamps
    end
    add_index :port_details, :details, using: :gin
  end
end
