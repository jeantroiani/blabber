require 'spec_helper'


feature 'Visitors and users can see posts' do
	
	before(:each) do
		user = User.create(name:      "Jean",
											 user_name: "@digitalguest",
											 email:     "jean@icloud.com",
											 password:  						"right", 
											 password_confirmation: "right"
											 )
	
		Post.create(text:	   "I am enjoying this tune",
								user_id: user.id
								)		
	end
		
	scenario 'when opening the homepage' do	
		visit('/')
		expect(page).to have_content("I am enjoying this tune,@digitalguest")
	end

end

feature 'Users can open account to post' do
	
	scenario 'When in the homepage you can open your account' do
		visit('/sign_up')
		fill_in 'name', 								 with: "Jean"
		fill_in	'username',							 with: "@digitalguest"
		fill_in 'email', 								 with: "jean@icloud.com"
		fill_in 'password', 						 with: "right"
		fill_in 'password_confirmation', with: "right"
		click_button("Submit")
		expect(User.last.email).to eq 'jean@icloud.com'
		visit ('/')
	end

	scenario 'When in the homepage you cannot open your account if you type a wrong password' do
		visit('/sign_up')
		fill_in 'name', 								 with: "Jean"
		fill_in	'username',							 with: "@digitalguest"
		fill_in 'email', 								 with: "jean@icloud.com"
		fill_in 'password', 						 with: "right"
		fill_in 'password_confirmation', with: "wrong"
		click_button("Submit")
		expect(User.count).to eq 0
		visit('/sign_up')
	end

end

feature 'Users can sign in into an account to post' do

	before(:each) do
		User.create(name:      						 "Jean",
							  user_name: 						 "@digitalguest",
							  email:     						 "jean@icloud.com",
							  password:  						 "right", 
							  password_confirmation: "right"
							  )
	end

	scenario 'When in the homepage you can sign in if you have an account' do
		visit('/')
		fill_in 'username', with: "@digitalguest"
		fill_in 'password',	with: "right"
		click_button("Submit")
		expect(page).to have_content "Welcome @digitalguest"
		
	end
end

feature 'Users can sign out from their account' do
 	before(:each) do
		User.create(name:      						 "Jean",
							  user_name: 						 "@digitalguest",
							  email:     						 "jean@icloud.com",
							  password:  						 "right", 
							  password_confirmation: "right"
							  )
	end

 	scenario 'from home, people can sign out' do
 		visit('/')
		fill_in 'username', with: "@digitalguest"
		fill_in 'password',	with: "right"
		click_button("Submit")
 		click_button("Sign out")
 		expect(page).to have_content "See you soon"
 	end
end

feature 'Users can post in the wall' do
 	before(:each) do
		User.create(name:      						 "Jean",
							  user_name: 						 "@digitalguest",
							  email:     						 "jean@icloud.com",
							  password:  						 "right", 
							  password_confirmation: "right"
							  )
	end

 	scenario 'users can post if their are signed' do
 		visit('/')
		fill_in 'username', with: "@digitalguest"
		fill_in 'password',	with: "right"
		click_button("Submit")
		fill_in 'post', with: "I am enjoying this tune"
		click_button("Post")
 		expect(page).to have_content("I am enjoying this tune,@digitalguest")
 	end
end





		
