require 'spec_helper'


feature 'Visitors and users can see posts' do
	
	before(:each) do
		user = User.create(name:      "Jean",
											 user_name: "@digitalguest",
											 email:     "jean@icloud.com")
	
		Post.create(text:	   "I am enjoying this tune",
								user_id: user.id
								)		
	end
		
	scenario 'When opening the homepage' do	
		visit('/')
		expect(page).to have_content("I am enjoying this tune,@digitalguest")
	end

end

feature 'Users have account to post' do
	
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

	scenario 'When in the homepage you can open your account' do
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




		
