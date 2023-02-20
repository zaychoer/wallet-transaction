class AddColumnOperationTypeToTransactionsAndUpdateColumnToIdNullable < ActiveRecord::Migration[7.0]
  def up
    add_column :transactions, :operation_type, :string
    change_column :transactions, :from_id, :integer, null: true
  end

  def down
    change_column :transactions, :from_id, :integer, null: false
    remove_column :transactions, :operation_type, :string
  end
end
