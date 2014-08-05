require 'sinatra'
require 'data_mapper'
require 'bcrypt'
require 'dm-validations'
require 'rack-flash'

enable :sessions

env = ENV["RACK_ENV"] || "development"


use Rack::Flash
set :root, File.join(File.dirname(__FILE__), '..')
set :views, Proc.new { File.join(root, "views") } 

DataMapper.setup(:default, "postgres://localhost/blabber_#{env}")
require './lib/user'
require './lib/post'
DataMapper.finalize
DataMapper.auto_upgrade!

get '/' do
	@posts=Post.all
	erb :index
end

get '/sign_up' do	
	erb :sign_up
end


post '/sign_up' do
	@user=	User.create(name: 					       		 params[:name],
											user_name: 			       "@"+params[:username],
											email: 					       		 params[:email],
											password: 			 			 		 params[:password],
											password_confirmation: 		 params[:password_confirmation]
										 )
	if @user.save
		session[:user]=@user.id
		redirect ('/')

	else
		flash[:errors]=@user.errors.full_messages
		redirect ('/sign_up')
	end
end

post '/' do
	username= params[:username]
	password= params[:password]
	@user = User.authenticate(username,password) 

	if @user
		session[:user]= @user.id
		redirect ('/')
	else
		flash[:errors]="Password or email invalid"
		redirect ('/')
	end 
end

post '/sign_out' do
	session[:user]= params[:sign_out]
	flash[:notice]= "See you soon!"
	redirect ('/')
end

post '/post_it' do
	user = User.first(id: session[:user])
	Post.create(text: params[:post],
		user_id: user.id)
	redirect ('/')
end

get '/user_info/:user' do
	user = User.first(user_name: params[:user])
 	@posts = Post.all(user_id: user.id)
 	erb :user_info
end

def user_of_session
	User.first(id: session[:user]) if session[:user]
end









