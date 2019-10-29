class CreateHistoricalWaitTimes < ActiveRecord::Migration[5.2]
  def change
    create_table :historical_wait_times do |t|
      t.string :port_number, default: nil
      t.integer :month_number, default: nil
      t.integer :bwt_day, default: nil
      t.integer :time_slot, default: nil
      t.integer :cv_time_avg, default: nil
      t.integer :xcv_time_avg, default: nil
      t.integer :pv_time_avg, default: nil
      t.integer :xpv_time_avg, default: nil
      t.integer :pv_ready_lanes_time_avg, default: nil
      t.integer :ped_time_avg, default: nil
      t.integer :ped_ready_lanes_time_avg, default: nil
      t.timestamps
    end
    add_index :historical_wait_times, :port_number
    add_index :historical_wait_times, :month_number
    add_index :historical_wait_times, :time_slot
    add_index :historical_wait_times, :bwt_day
  end
end
