require_relative 'menu'
require_relative 'user'
require_relative 'feature'
require_relative 'seed'

class Menu
  def self.appname
    "DSC Bank ATM"
  end

  def self.welcome
    puts "\nWelcome to #{self.appname}."
    # puts "Please enter your ATM card."; atmCardId = gets.chomp
    puts "Please enter your ATM card."; atmCardId = "80e711df-8c8d-4d1b-871e-7e1528675d11"
    customers = Seed.createCustomers
    Feature.authenticationCard(customers, atmCardId)
  end

  def self.instructions
    x=0
    puts 'Please select from the following:'
    puts '-' * 40
    puts 'Description'.ljust(30)              + 'Command'.rjust(10)
    puts 'Instructions'.ljust(30,'.')         + "#{x+=1}".rjust(10)
    puts 'Print Balance'.ljust(30,'.')        + "#{x+=1}".rjust(10)
    puts 'Print Transactions'.ljust(30,'.')   + "#{x+=1}".rjust(10)
    puts 'Transfer Funds'.ljust(30,'.')       + "#{x+=1}".rjust(10)
    puts 'Deposit'.ljust(30,'.')              + "#{x+=1}".rjust(10)
    puts 'Cash Withdrawal'.ljust(30,'.')      + "#{x+=1}".rjust(10)
    puts 'Cash Advance'.ljust(30,'.')         + "#{x+=1}".rjust(10)
    puts 'Make Payment'.ljust(30,'.')         + "#{x+=1}".rjust(10)
    puts 'Exit'.ljust(30,'.')                 + 'x'.rjust(10)
    puts '-' * 40    
  end

  def system(customer)
    # puts 'Enter transaction command or 1 to see instructions.'
    control_loop
  end

  def get_acc_info
    print 'Enter Description: '; @description = "gets.chomp"
    print 'Enter Amount: '     ; @amount = gets.chomp.to_f
  end

  def control_loop
    user_choice = ''
    loop do user_choice != 'x'
      i = 0
      print 'Enter Command (or 1 for menu, x to exit): '
      user_choice = gets.chomp.to_s.downcase

      case user_choice
      when "#{i+=1}".to_s then Menu.instructions
      when "#{i+=1}".to_s #print balance
        puts "choose account by numbered menu and get balance info"
      when "#{i+=1}".to_s #print transactions
        puts "choose account by numbered menu and get transactions info"
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

  def self.greeting(first_name, last_name)
    puts "\nHello #{first_name} #{last_name}"
  end

  def self.goodbye
    puts "Thank you for using #{appname}. \nGoodbye!\n\n"
  end
end


  # def info
  #   puts '-' * 40
  #   puts "#{Name}'s Bank Accounts".center(42)
  #   puts '-' * 40
  # end