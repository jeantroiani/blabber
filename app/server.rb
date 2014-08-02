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
	@user=	User.create(name: 					       params[:name],
											user_name: 			       params[:username],
											email: 					       params[:email],
											password: 			 			 params[:password],
											password_confirmation: params[:password_confirmation]
										 )
	if @user.save
		redirect ('/')
	else
		flash[:errors]=@user.errors.full_messages
		redirect ('/sign_up')
	end
end









