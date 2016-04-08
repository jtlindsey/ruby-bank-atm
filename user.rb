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

  def self.newAccount(userId, accountNum, accountType)
    {
      userId: userId,
      accountNum: accountNum,
      accountType: accountType,
      transactions: []
    }
  end

  def self.newCheckingTransaction(userId, accountNum, transactionType, amount)
    {
      userId: userId,
      accountNum: accountNum,
      date: DateTime.now,
      transactionType: transactionType,
      amount: amount
    }
  end

  def self.findUserByCard(customers, atmCardId)
    lookup = customers.find {|customer| customer[:atmCardId] == atmCardId}
    (lookup != nil) ? lookup : false
  end

  def self.findUser(customers, userId)
    # customers.select {|customer| customer[:userId] == userId }
    customers.find {|customer| customer[:userId] == userId}
  end

  def self.getUserAccounts(customer)
    choice = 0
    customer[:accounts].each {|hash| 
      choice += 1
      Menu.listUserAccounts(hash[:accountType], hash[:accountNum], choice)
    }
  end

  def self.getUserAccount(customer)
    # get single account info
    print 'Which account? '; accNumber = gets.chomp.to_i
    customer[:accounts][accNumber-1]
  end

  def self.getUserAccountBalance(customerAccount)
    # balance = customerAccount[:transactions].each {|transaction| puts transaction[:amount] }
    customerAccount[:transactions].inject(0) { |balance, transaction|  balance += transaction[:amount]}    
  end

  def self.findUserAccountTransaction
  end

end

# finding customer by atmCardId
# customers.select {|customer| customer[:atmCardId] == "0df20751-e24f-481b-9b75-8c26efee3198" }
