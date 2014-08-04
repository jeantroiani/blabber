require './app/server'

class User

	include DataMapper::Resource
	
	attr_accessor :password_confirmation
	attr_reader 	:password

	property :id,	Serial
	property :name, String
	property :user_name, String,:unique => true
	property :email, String,:unique => true
	property :password_digest, Text
	property :password_token, String
	property :password_token_time, String

	has n, :posts

	validates_confirmation_of :password
	validates_uniqueness_of :email
	validates_uniqueness_of :user_name

	def password=(password)
		@password=password
	  self.password_digest = BCrypt::Password.create(password)
	end

	def self.authenticate(user_name,password)
		user = first(user_name: user_name) 
		if user			
			user if BCrypt::Password.new(user.password_digest) == password	
		else
			nil
		end
	end

end
