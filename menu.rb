require_relative 'menu'
require_relative 'user'
require_relative 'feature'
require_relative 'seed'

class Menu
  @@ljustNum = 40
  @@rjustNum = 3
  @@border = 47  

  def self.appname
    "DSC Bank ATM"
  end

  def self.welcome
    puts "\nWelcome to #{self.appname}."
    # puts "Please enter your ATM card."; atmCardId = gets.chomp
    puts "Please enter your ATM card:"; atmCardId = "80e711df-8c8d-4d1b-871e-7e1528675d11"
    customers = Seed.createCustomers
    Feature.authenticationCard(customers, atmCardId)
  end

  def self.mainMenuChoices
    [
      "Instructions",
      "Print Balance",
      "Print Transactions",
      "Transfer Funds",
      "Deposit",
      "Cash Withdrawal",
      "Cash Advance",
      "Make Payment"
    ]
  end

  def self.transactionChoices
    [
      "Deposit",
      "Payment",
      "Transfer Funds",
      "Cash Withdrawal",
      "Cash Advance"
    ]
  end

  def self.instructions
    x=0
    puts 'Please select from the following:'
    puts '-' * @@border
    puts 'Description'.ljust(@@ljustNum)  + 'Command'.rjust(@@rjustNum)
    Menu.mainMenuChoices.each {|menuList|
      puts menuList.ljust(@@ljustNum,'.') + "#{x+=1}".rjust(@@rjustNum)
    }
    puts 'Exit'.ljust(@@ljustNum,'.')        + 'x'.rjust(@@rjustNum)
    puts '-' * @@border
  end

  def get_acc_info
    print 'Enter Description: '; @description = gets.chomp
    print 'Enter Amount: '     ; @amount = gets.chomp.to_f
  end

  def control_loop(customer)
    user_choice = ''
    loop do user_choice != 'x'
      i = 0
      print 'Enter Command (or 1 for menu, x to exit): '
      user_choice = gets.chomp.to_s.downcase

      case user_choice
      when "#{i+=1}".to_s then Menu.instructions
      when "#{i+=1}".to_s #print balance
        Menu.printBalance(customer)
      when "#{i+=1}".to_s #print transactions
        Menu.printTransactions(customer)





      when "#{i+=1}".to_s #update transfer funds
        puts "choose from acc and to accc by numbered menu and get amount"
      when "#{i+=1}".to_s #deposit
        puts "choose account by numbered menu and get deposit amount"
      when "#{i+=1}".to_s #cash withdrawal
        puts "choose account by numbered menu and get withdrawal amount"
      when "#{i+=1}".to_s #cash advance
        puts "choose account by numbered menu and get withdrawal-advance amount"
      when "#{i+=1}".to_s #payment
        puts "choose account by numbered menu and get payment amount"
      when 'x' then Menu.goodbye
      else
        puts 'Invalid Choice.'
        Menu.instructions
      end

      break if user_choice == 'x'
    end      
  end

  def self.chooseAccount(customer)
    puts 'Choose Account:'.ljust(@@ljustNum,'.')        + 'Choice'.rjust(@@rjustNum)
    puts '-' * @@border
    User.getUserAccounts(customer) #plural
    puts '-' * @@border
    User.getUserAccount(customer) #single
  end

  def self.printBalance(customer)
    account = Menu.chooseAccount(customer)
    puts "#{account[:accountType]}-#{account[:accountNum]}"
    puts "Your Balance is: #{User.getUserAccountBalance(account)}"
  end

  def self.printTransactions(customer)
    account = Menu.chooseAccount(customer)
    puts "Transactions for: #{account[:accountType]}-#{account[:accountNum]}"
    transactions = User.getUserAccountTransactions(account)
    padding = 8
    transactions.each {|transaction| 
    puts "#{transaction[:date]}".ljust(padding) + 
          " #{transaction[:transactionType]}".ljust(padding) + 
          " #{transaction[:amount]}".ljust(padding) +
          " #{transaction[:comment]}"
    }
  end

  def self.listUserAccounts(item1, item2, choice)
    puts "#{item1}-#{item2}".ljust(@@ljustNum,'.') + "#{choice}".rjust(@@rjustNum)
  end

  def self.greeting(first_name, last_name)
    puts "\nHello #{first_name} #{last_name}"
  end

  def self.goodbye
    puts "Thank you for using #{appname}. \nGoodbye!\n\n"
  end
end
