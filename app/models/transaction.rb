class Transaction < ApplicationRecord
  before_validation :generate_transaction_number

  belongs_to :from, :class_name => 'Wallet', :foreign_key => :from_id, optional: true
  belongs_to :to, :class_name => 'Wallet', :foreign_key => :to_id

  monetize :amount_cents

  validates :amount, presence: true, numericality: true
  validates :transaction_number, presence: true, uniqueness: true
  validates :transaction_type, presence: true

  enum operation_type: {
    transfer: 'transfer',
    withdraw: 'withdraw',
    deposit: 'deposit'
  }

  enum transaction_type: {
    debit: 'credit',
    credit: 'debit',
  }

  def source
    Wallet.find_by_id(self.from)
  end

  def target
    Wallet.find_by_id(self.to)
  end

  def generate_transaction_number
    if self.new_record?
      self.transaction_number = SecureRandom.uuid
    end
  end
end
