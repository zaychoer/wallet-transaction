class TransactionsController < ApplicationController
  before_action :authenticate_user!

  def index
    # 'status_id = 2 or status_id = 5'
    wallet_id = current_user.wallet.id
    @q = Transaction.ransack(params[:q])
    @pagy, @transactions = pagy(@q.result.order(created_at: :desc).where("from_id = #{wallet_id}"), items: 5)
  end

  def new
    @wallets = Wallet.where.not(user: current_user)
    @operation_types = Transaction.operation_types
    @from = current_user.wallet.id
  end

  def create
    begin
      ActiveRecord::Base.transaction do
        transaction_type = ''
        wallet_source_balance = 0
        wallet_target_balance = 0
        amount = params[:amount].to_f
        operation_type = params[:operation_type]

        if operation_type == 'transfer'
          wallet_source_balance = wallet_source.balance.to_f
          wallet_target_balance = wallet_target.balance.to_f
          wallet_source.update!(balance: wallet_source_balance - amount)
          wallet_target.update!(balance: wallet_target_balance + amount)

          Transaction.create!(
            amount: params[:amount],
            from: wallet_source,
            to: wallet_target,
            transaction_type: 'credit',
            operation_type: operation_type
          )

          Transaction.create!(
            amount: params[:amount],
            to: wallet_source,
            from: wallet_target,
            transaction_type: 'debit',
            operation_type: operation_type
          )
        end

        if operation_type == 'deposit'
          transaction_type = 'debit'
          wallet_source_balance = wallet_source.balance.to_f
          wallet_source.update!(balance: wallet_source_balance + amount)

          Transaction.create!(
            amount: params[:amount],
            to: wallet_source,
            from: wallet_source,
            transaction_type: transaction_type,
            operation_type: operation_type
          )
        end

        if operation_type == 'withdraw'
          transaction_type = 'credit'
          wallet_source_balance = wallet_source.balance.to_f
          wallet_source.update!(balance: wallet_source_balance - amount)

          Transaction.create!(
            amount: params[:amount],
            to: wallet_source,
            from: wallet_source,
            transaction_type: transaction_type,
            operation_type: operation_type
          )
        end

        redirect_to transactions_path, notice: "Success create transaction"
      end
    rescue ActiveRecord::RecordInvalid
      redirect_to transactions_path, notice: "Failed create transaction"
    end
  end

  private
  def wallet_source
    wallet_source = Wallet.find_by_id(params[:from])
  end

  def wallet_target
    wallet_target = Wallet.find_by_id(params[:to])
  end
end
