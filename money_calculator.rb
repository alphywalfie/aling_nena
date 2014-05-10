class MoneyCalculator

require 'sinatra'

attr_accessor :ones, :fives, :tens, :twenties, :fifties, :hundreds, :five_hundreds, :thousands

  def initialize(ones, fives, tens, twenties, fifties, hundreds, five_hundreds, thousands)
		self.ones = ones
		self.fives = fives
		self.tens = tens
		self.twenties = twenties
		self.fifties = fifties
		self.hundreds = hundreds
		self.five_hundreds = five_hundreds
		self.thousands = thousands
		
	end
	
	total_payment = (ones*1 + fives*5 + tens*10 + twenties*20 + fifties*50 + hundreds*100 + five_hundreds*500 + thousands*1000)
	
	def change(cost)
		@cost = cost.to_i
		@totalpayment = total_payment
		@change_amount = totalpayment - @cost
		@thousands_amount = @change_amount/1000
		@five_hundreds_amount = (@thousands_amount%1000)/500
		@hundreds_amount = (@five_hundreds_amount%500)/1000
		@fifties_amount = (@hundreds_amount%100)/50
		@twenties_amount = (@fifties_amount%50)/20
		@tens_amount = (@twenties_amount%20)/10
		@fives_amount = (@tens_amount%10)/5
		@ones_amount = @fives_amount%5
		
		@change_hash = {:ones => @ones_amount, :fives => @fives_amount, :tens => @tens_amount, :twenties => @twenties_amount, :fifties => @fifties_amount, :hundreds => @hundreds_amount, :five_hundreds => @five_hundreds_amount, :thousands => @thousands_amount}
	end	
		
    # each parameter represents the quantity per denomination of money
    # these parameters can be assigned to instance variables and used for computation

    # add a method called 'change' that takes in a parameter of how much an item costs
    # and returns a hash of how much change is to be given
    # the hash will use the denominations as keys and the amount per denomination as values
    # i.e. {:fives => 1, fifties => 1, :hundreds => 3}
end

@moneys = MoneyCalculator.new(1, 5, 7, 5, 7, 1, 0, 1)
@moneys.change(250)