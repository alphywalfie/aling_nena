require 'sinatra'
require './boot.rb'

products = Item.all
# ROUTES FOR ADMIN SECTION
get '/admin' do
  @products = products
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
	@products = products.sample(10)
	erb :index
end

get '/products' do
	@products = products
	erb :product_list
end

get '/buy_item_form/:id' do
	@product = Item.find(params[:id])
	erb :buy_form
end

post '/buy_item/:id' do
	@product = Item.find(params[:id])
	quantity = params[:quantity].to_i
	newquantity = @product.quantity - quantity
	newsold  = @product.sold + quantity
	@product.update_attributes!(
	quantity: newquantity, 
	sold: newsold,
	)
	
	"The new quantity is #{@product.quantity}"
	
	redirect to '/'
end