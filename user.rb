require 'date'
class User

  def self.newUser(userId, firstName, lastName, atmPin, atmCardId)
    {
      userId: userId,
      atmCardId: atmCardId,
      atmPin: atmPin,
      firstName: firstName,
      lastName: lastName,
      accounts: []
    }
  end

  def self.newAccount(userId, accountNum, accountType, creditLimit = 0)
    {
      userId: userId,
      accountNum: accountNum,
      accountType: accountType,
      transactions: [],
      creditLimit: creditLimit
    }
  end

  def self.newTransferTransaction(userId, accountNum, transactionType, amount, comment="")
    {
      userId: userId,
      accountNum: accountNum,
      date: Date.today.to_s,
      transactionType: transactionType,
      amount: amount,
      comment: comment
    }
  end

  def self.newTransaction(userId, accountNum, transactionType, amount, comment="")
    {
      userId: userId,
      accountNum: accountNum,
      date: Date.today.to_s,
      transactionType: transactionType,
      amount: amount,
      comment: comment
    }
  end

  def self.defaultAccounts
    [
      "Checking", 
      "Savings", 
      "Loan", 
      "Mortgage", 
      "Car Loan", 
      "Boat Loan", 
      "Credit Card"
    ]
  end

  def self.liabilityAccounts
    [
      "Loan", 
      "Mortgage", 
      "Car Loan", 
      "Boat Loan", 
      "Credit Card"
    ]
  end

  def self.findUserByCard(customers, atmCardId)
    lookup = customers.find {|customer| customer[:atmCardId] == atmCardId}
    (lookup != nil) ? lookup : false
  end

  def self.findUser(customers, userId)
    # customers.select {|customer| customer[:userId] == userId }
    customers.find {|customer| customer[:userId] == userId}
  end

  def self.getUserAccountsByType(customer, accountTypes) #plural
    choice = 0
    User.defaultAccounts 
    accountTypes = User.defaultAccounts if accountTypes.empty?

    customer[:accounts].each {|hash| 
      choice += 1
      if accountTypes.include?(hash[:accountType])
        Menu.listUserAccounts(hash[:accountType], hash[:accountNum], choice)
      end
    }
  end

  def self.getUserAccount(customer) #single
    print 'Which account? '; accNumber = gets.chomp.to_i
    customer[:accounts][accNumber-1]
  end

  def self.getUserAccountBalance(customerAccount)
    customerAccount[:transactions].inject(0) { |balance, transaction|  balance += transaction[:amount]}    
  end

  def self.getUserAccountTransactions(customerAccount)
    customerAccount[:transactions]
  end

end