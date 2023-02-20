class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.monetize :amount
      t.integer :from_id, null: false
      t.integer :to_id, null: false
      t.string :transaction_type
      t.string :transaction_number

      t.timestamps
    end
  end
end
