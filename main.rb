require 'sinatra'
require './boot.rb'
require './money_calculator.rb'

# ROUTES FOR ADMIN SECTION
get '/admin' do
  @products = Item.all
  erb :admin_index
end

get '/new_product' do
  @product = Item.new
  erb :product_form
end

post '/create_product' do
  Item.create!(
    name: params[:name],
    price: params[:price],
    quantity: params[:quantity],
    sold: 0
  )
  redirect to '/admin'
end

get '/edit_product/:id' do
  @product = Item.find(params[:id])
  erb :product_form
end

post '/update_product/:id' do
  @product = Item.find(params[:id])
  @product.update_attributes!(
    name: params[:name],
    price: params[:price],
    quantity: params[:quantity],
  )
  redirect to '/admin'
end

get '/delete_product/:id' do
  @product = Item.find(params[:id])
  @product.destroy!
  redirect to '/admin'
end
# ROUTES FOR ADMIN SECTION

get '/about' do
	erb :about
end

get '/' do
	@productsall = Item.all
	@products = @productsall.sample(10)
	erb :index
end

get '/products' do
	@products = Item.all
	erb :product_list
end

get '/buy_item_form/:id' do
	@product = Item.find(params[:id])
	erb :buy_form
end

post '/buy_item/:id' do
	@product = Item.find(params[:id])
	@quantity = params[:quantity].to_i
	@cost = (@product.price * @quantity).to_f
	@money_calc = MoneyCalculator.new(params[:ones], params[:fives], params[:tens], params[:twenties], params[:fifties], params[:hundreds], params[:five_hundreds], params[:thousands])
	if(@quantity <= @product.quantity && @cost <= (@money_calc.total_payment).to_f)
		@new_quantity = @product.quantity - @quantity
		@new_sold  = @product.sold + @quantity
		@product.update_attributes!(
		quantity: @new_quantity, 
		sold: @new_sold,
		)
		@change_amount = @money_calc.change_amount(@money_calc.total_payment, @cost)
		@change = @money_calc.change(@cost)
	else
		redirect to '/error'
	end
	erb :buy_confirmation
end

get '/error' do
	erb :error
end