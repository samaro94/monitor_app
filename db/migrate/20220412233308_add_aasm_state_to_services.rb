class AddAasmStateToServices < ActiveRecord::Migration[7.0]
  def change
    add_column :services, :aasm_state, :string
  end
end
