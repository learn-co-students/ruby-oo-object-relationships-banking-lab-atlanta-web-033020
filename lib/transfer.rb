require 'pry'

class Transfer
  attr_reader :sender, :receiver, :amount
  attr_accessor :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    sender.valid? and receiver.valid?
  end

  def valid_transaction?
    accounts_valid = self.valid?
    trans_pending = self.status == "pending"
    funds_available = sender.balance > self.amount
    accounts_valid and trans_pending and funds_available
  end

  def execute_transaction
    if self.valid_transaction?
      sender.balance -= self.amount
      receiver.balance += self.amount
      self.status = "complete"
    else
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def valid_reverse?
    trans_complete = self.status == "complete"
  end

  def reverse_transfer
    if self.valid_reverse?
      sender.balance += self.amount
      receiver.balance -= self.amount
      self.status = "reversed"
    end
  end
end
