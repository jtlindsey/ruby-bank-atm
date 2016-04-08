require_relative 'user'
# ATM's are for existing customers.
# ATM is working off existing bank database
# This is seed customer database
# Has customers with many of a single type of account
# and many types of accounts.
# 3 Customer examples:
# one with every type of account
# one with several of one type of account
# one with a little of both
# require 'securerandom'
# SecureRandom.uuid

class Seed
  def self.createCustomers
    # Make some customers
    customers = []
    customers.push(User.newUser(1, "Ken", "Doe", "3293", "92f086dd-a76a-4bae-81a4-8f3694f5d478"))
    customers.push(User.newUser(2, "Frank", "Smith", "5690", "0df20751-e24f-481b-9b75-8c26efee3198"))
    customers.push(User.newUser(3, "Jane", "English", "1174", "80e711df-8c8d-4d1b-871e-7e1528675d11"))

    # Make some accounts for those customers
    # newAccount(userId, accountNum, accountType)
    newcustomerid = 1
    acustomer = User.findUser(customers, newcustomerid)
    acustomer[:accounts].push(User.newAccount(newcustomerid, 10000 + newcustomerid,"Checking"))
    acustomer[:accounts].push(User.newAccount(newcustomerid, 20000 + newcustomerid,"Savings"))
    acustomer[:accounts].push(User.newAccount(newcustomerid, 30000 + newcustomerid,"Loan"))
    acustomer[:accounts].push(User.newAccount(newcustomerid, 40000 + newcustomerid,"Mortgage"))
    acustomer[:accounts].push(User.newAccount(newcustomerid, 50000 + newcustomerid,"Car Loan"))
    acustomer[:accounts].push(User.newAccount(newcustomerid, 60000 + newcustomerid,"Boat Loan"))
    acustomer[:accounts].push(User.newAccount(newcustomerid, 70000 + newcustomerid,"Credit Card"))

    # Make some transactions for that customers accounts
    # newCheckingTransaction(userId, accountNum, transactionType, amount , comment)
    account = acustomer[:accounts].find {|account| account[:accountNum] == (10000 + newcustomerid)}
    account[:transactions].push(User.newCheckingTransaction(newcustomerid, 10000 + newcustomerid, "Deposit", 900, "transfer?fromacc: toacc: info"))


    newcustomerid = 2
    acustomer = User.findUser(customers, newcustomerid)
    acustomer[:accounts].push(User.newAccount(newcustomerid, 20000 + newcustomerid,"Savings"))
    acustomer[:accounts].push(User.newAccount(newcustomerid, 21000 + newcustomerid,"Savings"))
    acustomer[:accounts].push(User.newAccount(newcustomerid, 22000 + newcustomerid,"Savings"))

    newcustomerid = 3
    acustomer = User.findUser(customers, newcustomerid)
    acustomer[:accounts].push(User.newAccount(newcustomerid, 10000 + newcustomerid,"Checking"))
    acustomer[:accounts].push(User.newAccount(newcustomerid, 20000 + newcustomerid,"Savings"))
    acustomer[:accounts].push(User.newAccount(newcustomerid, 21000 + newcustomerid,"Savings"))
    acustomer[:accounts].push(User.newAccount(newcustomerid, 40000 + newcustomerid,"Mortgage"))
    acustomer[:accounts].push(User.newAccount(newcustomerid, 50000 + newcustomerid,"Car Loan"))
    acustomer[:accounts].push(User.newAccount(newcustomerid, 51000 + newcustomerid,"Car Loan"))
    acustomer[:accounts].push(User.newAccount(newcustomerid, 70000 + newcustomerid,"Credit Card"))

    # Make some transactions for that customers accounts
    # newCheckingTransaction(userId, accountNum, transactionType, amount, comment)
    account = acustomer[:accounts].find {|account| account[:accountNum] == (10000 + newcustomerid)}
    account[:transactions].push(User.newCheckingTransaction(newcustomerid, 10000 + newcustomerid, "Deposit", 900, "transfer?fromacc: toacc: info"))
    account[:transactions].push(User.newCheckingTransaction(newcustomerid, 10000 + newcustomerid, "Deposit", 1250, "transfer?fromacc: toacc: info"))

    customers
  end
end

# Seed.createCustomers