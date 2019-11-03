class CreateHolidayWaitTimes < ActiveRecord::Migration[5.2]
  def change
    create_table :holiday_wait_times do |t|
      t.string :port_number
      t.datetime :bwt_date, default: nil
      t.integer :time_slot, default: nil
      t.integer :cv_time, default: nil
      t.integer :xcv_time, default: nil
      t.integer :pv_time, default: nil
      t.integer :xpv_time, default: nil
      t.integer :pv_ready_lanes_time, default: nil
      t.integer :ped_time, default: nil
      t.integer :ped_ready_lanes_time, default: nil
      t.timestamp :holiday_date, default: nil

      t.timestamps
    end
    add_index :holiday_wait_times, :port_number
    add_index :holiday_wait_times, :bwt_date
    add_index :holiday_wait_times, :holiday_date
    add_index :holiday_wait_times, :time_slot
  end
end
