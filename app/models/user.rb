class User < ApplicationRecord
  after_create :create_wallet

  devise :database_authenticatable,
        :registerable,
        :recoverable,
        :rememberable,
        :validatable

  has_one_attached :avatar
  has_one :wallet

  def name
    @name ||= self[:name].presence || email.split("@").first
  end

  def create_wallet
    wallet_id = self.email.split("@").first
    Wallet.create!(
      balance: 0,
      user: self,
      wallet_id: wallet_id
    )
  end
end
