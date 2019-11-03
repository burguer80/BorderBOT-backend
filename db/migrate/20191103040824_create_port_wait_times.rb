class CreatePortWaitTimes < ActiveRecord::Migration[5.2]
  def change
    create_table :port_wait_times do |t|
      t.string :port_number
      t.datetime :date, default: nil
      t.jsonb :data, default: nil

      t.timestamps
    end

    add_index :port_wait_times, :data, using: :gin
    add_index :port_wait_times, %i[date port_number]
    add_index :port_wait_times, :port_number
  end
end
