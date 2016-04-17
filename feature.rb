require_relative 'user'
require 'json'

class Feature
  def self.authenticationCard(customers)
    atmCardId = Menu.printATMcardAuthentication
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
      pinEntry = Menu.printATMcardPinAuthentication
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
    Menu.printGreeting(customer[:firstName], customer[:lastName])
    Menu.printInstructions
    Menu.new.printMainLoop(customer)
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

  def self.dailyTransactionLimitAmount
    10
  end

  def self.dailyWithdrawalLimitAmount
    500
  end

  def self.dailyTransactionLimit(account)
    limit = Feature.dailyTransactionLimitAmount
    todaysTransactions = 0
    account[:transactions].each {|transaction|
      todaysTransactions +=1 if transaction[:date] == Date.today.to_s
    }
    todaysTransactions >= limit ? true : false
  end

  def self.dailyWithdrawalLimit(account)
    limit = Feature.dailyWithdrawalLimitAmount
    todaysTotal = Feature.totalWithdrawalsToday(account)
    todaysTotal >= limit ? true : false
  end

  def self.totalWithdrawalsToday(account)
    todaysTotal = 0
    if User.liabilityAccounts.include?(account[:accountType])
      #use if withdrawal limit applies to all accounts (including liabilities)
      account[:transactions].each {|transaction|
        if transaction[:date] == Date.today.to_s && transaction[:amount] > 0
          todaysTotal += (transaction[:amount]) 
        end
      }
    else
      account[:transactions].each {|transaction|
        if transaction[:date] == Date.today.to_s && transaction[:amount] < 0
          todaysTotal += (transaction[:amount] * -1) 
        end
      }
    end
    todaysTotal
  end

  def self.deposit(account, amount)
    amount = (amount * -1) if User.liabilityAccounts.include?(account[:accountType])

    account[:transactions].push(
      User.newTransaction(
        account[:userId], 
        account[:accountNum], 
        "Deposit", 
        amount)
      )
  end

  def self.withdrawalCash(account, amount)
  #only on checking or savings
  #max $500 withdrawal per account per day
    account[:transactions].push(
      User.newTransaction(
        account[:userId], 
        account[:accountNum], 
        "Withdrawal Cash", 
        (-1 * amount))
      )
  end

  def self.withdrawalCashAdvance(account, amount)
    account[:transactions].push(
      User.newTransaction(
        account[:userId], 
        account[:accountNum], 
        "Withdrawal Cash Advance", 
        amount)
      )
  end

  def self.payment(fromAccount, toAccount, amount)
    Feature.withdrawalTransfer(fromAccount, amount, toAccount)
    Feature.depositTransfer(toAccount, (amount), fromAccount)
  end

  def self.transfer(fromAccount, toAccount, amount)
    #Note: Prof requested to be able to transfer funds between 'ANY' two accounts
    Feature.withdrawalTransfer(fromAccount, amount, toAccount)
    Feature.depositTransfer(toAccount, amount, fromAccount)
  end

  def self.depositTransfer(toAccount, amount, fromAccount)
    amount = (amount * -1) if User.liabilityAccounts.include?(toAccount[:accountType])

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
    amount = (amount * -1) if User.liabilityAccounts.include?(fromAccount[:accountType])

    fromAccount[:transactions].push(
      User.newTransferTransaction(
        fromAccount[:userId], 
        fromAccount[:accountNum], 
        "Withdrawal", 
        (-1 * amount), 
        "To: #{toAccount[:accountType]}-#{toAccount[:accountNum]}")
      )
  end

  def self.storedDataFileLocation
    # Get JSON database file location
    pathtofile = File.join(File.dirname(__FILE__), "/data/mydata.json")
  end

  def self.storedData
    # Get ALL user data
    pathtofile = Feature.storedDataFileLocation
    # Parse data, 'symbolize_names: true' to convert json string keys to symbols
    JSON.parse(IO.read(pathtofile), symbolize_names: true)
  end

  def self.getStoredDataAndSave(userSession)
    existingData = Feature.storedData
    # Find the data for the current user "userId = userSession[:userId]" in the... 
    # existingData object and replace it with the data from this session(userSession)
    userId = userSession[:userId]
    existingData.find {|customer| customer[:userId] == userId}.replace(userSession)

    # Save data as JSON with indentation (pretty_generate)
    File.open(Feature.storedDataFileLocation,"w") do |f|
      f.write(JSON.pretty_generate(existingData))
    end
    puts "Session successfully saved."
  end

# change all ids on transactions to indexed value incremented on unique identifier
# Time.now.to_i
end