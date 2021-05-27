require_relative 'user'

class Feature
  def self.authenticationCard(customers)
    atmCardId = Menu.printATMcardAuthentication
    userWithCard = User.findUserByCard(customers, atmCardId)
    case userWithCard
    when false then puts "That card is not accepted at this ATM.\nGoodbye!"
    else
      authenticationUser(userWithCard)
    end
  end

  def self.authenticationUser(userWithCard)
    x = 0
    access = false
    while x < 3
      pinEntry = Menu.printATMcardPinAuthentication
      x += 1
      if pinEntry == userWithCard[:atmPin]
        access = true
        puts 'success'
        break
      elsif pinEntry != userWithCard[:atmPin] && x < 3
        puts "Invalid Pin (#{x}). Try again."
      elsif x == 3
        puts "Invalid Pin (#{x}). Goodbye."
      end
    end
    puts loggedIn(userWithCard) if access == true
  end

  def self.loggedIn(customer)
    Menu.printGreeting(customer[:firstName], customer[:lastName])
    Menu.printInstructions
    atmPinCheck = true
    Menu.new.printMainLoop(customer, atmPinCheck)
  end

  def newTransaction(_customer)
    # max trans per account per day 10 handled at menu request
    transacton = {
      accountnum: 0,
      transactionid: 0,
      transactiontype: 'deposit withddrawal payment transfer',
      tranactiondate: datetime
    }
  end

  def self.dailyTransactionLimitAmount
    1000
  end

  def self.dailyWithdrawalLimitAmount
    5000
  end

  def self.dailyTransactionLimit(account)
    limit = Feature.dailyTransactionLimitAmount
    todaysTransactions = 0
    account[:transactions].each do |transaction|
      todaysTransactions += 1 if transaction[:date] == Date.today.to_s
    end
    todaysTransactions >= limit
  end

  def self.dailyWithdrawalLimit(account)
    limit = Feature.dailyWithdrawalLimitAmount
    todaysTotal = Feature.totalWithdrawalsToday(account)
    todaysTotal >= limit
  end

  def self.totalWithdrawalsToday(account)
    todaysTotal = 0
    if User.liabilityAccounts.include?(account[:accountType])
      # use if withdrawal limit applies to all accounts (including liabilities)
      account[:transactions].each do |transaction|
        todaysTotal += (transaction[:amount]) if transaction[:date] == Date.today.to_s && transaction[:amount] > 0
      end
    else
      account[:transactions].each do |transaction|
        todaysTotal += (transaction[:amount] * -1) if transaction[:date] == Date.today.to_s && transaction[:amount] < 0
      end
    end
    todaysTotal
  end

  def self.printValidateAvalibleFunds(fromAccount, amount)
    accBalance = User.getUserAccountBalance(fromAccount)
    if User.liabilityAccounts.include?(fromAccount[:accountType])
      ((fromAccount[:creditLimit] - accBalance) - amount) >= 0
    else
      (accBalance - amount) >= 0
    end
  end

  def self.deposit(account, amount)
    amount = (amount * -1) if User.liabilityAccounts.include?(account[:accountType])
    account[:transactions].push(
      User.newTransaction(
        account[:userId],
        account[:accountNum],
        'Deposit',
        amount
      )
    )
  end

  def self.withdrawalCash(account, amount)
    # only on checking or savings
    # max $500 withdrawal per account per day
    account[:transactions].push(
      User.newTransaction(
        account[:userId],
        account[:accountNum],
        'Withdrawal Cash',
        (-1 * amount)
      )
    )
  end

  def self.withdrawalCashAdvance(account, amount)
    account[:transactions].push(
      User.newTransaction(
        account[:userId],
        account[:accountNum],
        'Withdrawal Cash Advance',
        amount
      )
    )
  end

  def self.payment(fromAccount, toAccount, amount)
    Feature.withdrawalTransfer(fromAccount, amount, toAccount)
    Feature.depositTransfer(toAccount, amount, fromAccount)
  end

  def self.transfer(fromAccount, toAccount, amount)
    # NOTE: Prof requested to be able to transfer funds between 'ANY' two accounts
    Feature.withdrawalTransfer(fromAccount, amount, toAccount)
    Feature.depositTransfer(toAccount, amount, fromAccount)
  end

  def self.depositTransfer(toAccount, amount, fromAccount)
    amount = (amount * -1) if User.liabilityAccounts.include?(toAccount[:accountType])

    toAccount[:transactions].push(
      User.newTransaction(
        toAccount[:userId],
        toAccount[:accountNum],
        'Deposit',
        amount,
        "From: #{fromAccount[:accountType]}-#{fromAccount[:accountNum]}"
      )
    )
  end

  def self.withdrawalTransfer(fromAccount, amount, toAccount)
    amount = (amount * -1) if User.liabilityAccounts.include?(fromAccount[:accountType])

    fromAccount[:transactions].push(
      User.newTransaction(
        fromAccount[:userId],
        fromAccount[:accountNum],
        'Withdrawal',
        (-1 * amount),
        "To: #{toAccount[:accountType]}-#{toAccount[:accountNum]}"
      )
    )
  end
end
