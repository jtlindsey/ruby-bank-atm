require_relative 'user'

class Feature
  def self.authenticationCard(customers, atmCardId)
    userWithCard = User.findUserByCard(customers, atmCardId)

    case userWithCard
    when false then puts "That card is not accepted at this ATM.\nGoodbye!"
    else
      self.authenticationUser(userWithCard)
    end
  end

  def self.authenticationUser(userWithCard)
    x = 0
    access = false
    while x < 3
      # puts 'Enter your pin:'; pinEntry = gets.chomp
      puts 'Enter your pin:'; pinEntry = "1174"
      x += 1
      case 
      when pinEntry == userWithCard[:atmPin]
        access = true
        puts "success"
        break
      when pinEntry != userWithCard[:atmPin] && x <3
        puts "Invalid Pin (#{x}). Try again."
      when x == 3
        puts "Invalid Pin (#{x}). Goodbye."
      end
    end
    puts self.loggedIn(userWithCard) if access == true
  end

  def self.loggedIn(customer)
    Menu.greeting(customer[:firstName], customer[:lastName])
    Menu.instructions
    Menu.new.control_loop(customer)
  end

  def newTransaction(customer)
    #max trans per account per day 10 handled at menu request
    transacton = {
    accountnum: 0,
    transactionid: 0,
    transactiontype: "deposit withddrawal payment transfer",
    tranactiondate: datetime
    }
  end

  def self.dailyTransactionLimit(account)
    limit = 10
    todaysTransactions = 0
    account[:transactions].each {|transaction|
      todaysTransactions +=1 if transaction[:date] == Date.today.to_s
    }
    todaysTransactions >= limit ? true : false
  end

  def self.deposit(account)
  end

  def self.withdrawalCash(account)
  #only on checking or savings
  #max $500 withdrawal per account per day
  end

  def self.withdrawalCashAdvance(account)
  #credit card only
  #must be within credit avalible
  end

  def self.payment(account, fromAcc, toAcc)
  #to mortgage,car,boat and other loan
  end

  def self.transfer(fromAccount, toAccount, amount)
    #Note: Prof requested to be able to transfer funds between 'ANY' two accounts
    Feature.withdrawalTransfer(fromAccount, amount, toAccount)
    Feature.depositTransfer(toAccount, amount, fromAccount)
    # user.withdrawal(account, amount)
  end

  def self.depositTransfer(toAccount, amount, fromAccount)
    toAccount[:transactions].push(
      User.newTransferTransaction(
        toAccount[:userId], 
        toAccount[:accountNum], 
        "Deposit", 
        amount, 
        "From: #{fromAccount[:accountType]}-#{fromAccount[:accountNum]}")
      )
  end

  def self.withdrawalTransfer(fromAccount, amount, toAccount)
    fromAccount[:transactions].push(
      User.newTransferTransaction(
        fromAccount[:userId], 
        fromAccount[:accountNum], 
        "Withdrawal", 
        (-1 * amount), 
        "To: #{toAccount[:accountType]}-#{toAccount[:accountNum]}")
      )
  end

# change all ids on transactions to indexed value incremented on unique identifier
# Time.now.to_i
end