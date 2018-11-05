# frozen_string_literal: true

class CreatePorts < ActiveRecord::Migration[5.2]
  def change
    create_table :ports do |t|
      t.timestamp :taken_at
      t.string :status
      t.jsonb :data
      t.string :number

      t.timestamps
    end
    add_index :ports, :data, using: :gin
    add_index :ports, %i[taken_at number]
    add_index :ports, :number
  end
end
