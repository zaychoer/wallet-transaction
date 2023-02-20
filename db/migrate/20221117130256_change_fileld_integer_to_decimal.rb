class ChangeFileldIntegerToDecimal < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|
      change_table :wallets do |t|
        dir.up   { t.change :balance_cents, :decimal, precision: 15, scale: 2 }
        dir.down { t.change :balance_cents, :integer }
      end

      change_table :transactions do |t|
        dir.up   { t.change :amount_cents, :decimal, precision: 15, scale: 2}
        dir.down { t.change :amount_cents, :integer }
      end
    end
  end
end
