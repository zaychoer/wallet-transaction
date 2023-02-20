class AddWalletIdToWallet < ActiveRecord::Migration[7.0]
  def change
    add_column :wallets, :wallet_id, :string
  end
end
