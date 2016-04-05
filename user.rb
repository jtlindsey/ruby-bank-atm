class User

  def self.newUser(userId, firstName, lastName, atmPin, atmCardId)
    user = {
    userId: userId,
    atmCardId: atmCardId,
    atmPin: atmPin,
    firstName: firstName,
    lastName: lastName,
    accounts: []
    }
  end

  def self.newAccount(userId, accountNum, accountType)
    account = {
    userId: userId,
    accountNum: accountNum,
    accountType: accountType,
    transactions: []
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

  def self.findUserAccount
  end

  def self.findUserAccountTransaction
  end

end

# finding customer by atmCardId
# customers.select {|customer| customer[:atmCardId] == "0df20751-e24f-481b-9b75-8c26efee3198" }
