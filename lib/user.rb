require './app/server'

class User

	include DataMapper::Resource
	
	attr_accessor :password_confirmation
	attr_reader 	:password

	property :id,	Serial
	property :name, String
	property :user_name, String
	property :email, String
	property :password_digest, Text
	property :password_token, String
	property :password_token_time, String

	has n, :posts

	validates_confirmation_of :password

	def password=(password)
			@password=password
	    self.password_digest = BCrypt::Password.create(password)
	end



end
