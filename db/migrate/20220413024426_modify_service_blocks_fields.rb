class ModifyServiceBlocksFields < ActiveRecord::Migration[7.0]
  def change
    change_column :service_blocks, :from, :time
    change_column :service_blocks, :to, :time
  end
end
