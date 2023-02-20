class CreateWallets < ActiveRecord::Migration[7.0]
  def change
    create_table :wallets do |t|
      t.monetize :balance, default: 0.0
      t.references :user
      t.timestamps
    end
  end
end
