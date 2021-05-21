## Automatic Teller Machine (ATM)

This is the code part of a Automatic Teller Machine term project at DSC. Written in ruby.

**There are a number of physical constraints one the ATM:**
[x] There are 3 payout boxes: 1 for notes, 1 for coins > 20mm and 1 for coins <= 20mm
[x] 5 notes are available: 1000, 500, 200, 100, 50
[x] 5 coins are available: 20 (40mm), 10 (20mm), 5 (50mm), 2 (30mm) and 1 (10mm)
[x] There's a finite amount of notes and coins

**We have the following user stories:**
[x] As a User I want to be able to enter an amount, so that I can specify how much money to withdraw
[ ] As a User I want to receive notes and coins that match the entered amount, so I can go spend the money
[ ] As a Bank I want the least number of notes and coins to be used for payout, so that I don’t have to refill often

### Getting Started

```
ruby start.rb
```

### Testing as a customer

Follow the on-screen prompts to test. There is one customer hard-coded in. Default data for the customers can be found in the mydata.json file. If you want to change the customer being used for testing, uncomment lines 90 and 96, and then comment lines 91 and 97 in the menu.rb file. Save and start the app and use one of the following 3 default customers:

**Ken Doe**  
ATM Card:  
92f086dd-a76a-4bae-81a4-8f3694f5d478  
Pin:  
3293

**Frank Smith**  
ATM Card:  
0df20751-e24f-481b-9b75-8c26efee3198  
Pin:  
5690

**Jane English**  
ATM Card:  
80e711df-8c8d-4d1b-871e-7e1528675d11  
Pin:  
1174

If this was being done for a real bank, no code would be written before getting exact authentication specifications and database API details from the bank, and ATM regulations from the FDIC. A test suite (TDD) would be built to easily test all parts of the code were still working properly when something was changed and exact features requested were included. Penetration testing would be performed against the program running on a test ATM machine connected to the real database.

### Notes

Entering in the wrong ATM Card key once will exit program.  
Entering in the wrong Pin 3 times will exit program.

You can checkout the different branches to view alternative versions of this app.
