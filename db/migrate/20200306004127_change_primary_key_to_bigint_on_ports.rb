class ChangePrimaryKeyToBigintOnPorts < ActiveRecord::Migration[6.0]
  def change
    change_column :historical_wait_times, :id, :bigint
    change_column :holiday_wait_times, :id, :bigint
    change_column :ports, :id, :bigint
    change_column :port_details, :id, :bigint
    change_column :port_wait_times, :id, :bigint
  end
end
