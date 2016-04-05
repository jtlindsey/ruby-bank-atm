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
    Menu.new.system(customer)
  end

  def self.listAccounts(userId)
  end

  def newTransaction
    transacton = {
    accountnum: 0,
    transactionid: 0,
    transactiontype: "deposit withddrawal payment transfer",
    tranactiondate: datetime
    #max trans per account per day 10
    }
  end

  def deposit
  end

  def withdrawalCash
  #only on checking or savings
  #max $500 withdrawal per account per day
  end

  def withdrawalCashAdvance
  #credit card only
  #must be within credit avalible
  end

  def payment
  #to mortgage,car,boat and other loan
  end

  def transfer
  #between any two accounts
  end

  def balance
  end

# change all ids on transactions to indexed value incremented on unique identifier
end
