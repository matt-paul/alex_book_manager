feature 'User sign up' do

  scenario 'I can sign up as a new user' do
    user = User.new(email: 'alice@example.com',
            password: '12345678',
            password_confirmation: '12345678')
    expect { sign_up(user) }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, alice@example.com')
    expect(User.first.email).to eq('alice@example.com')
  end

  scenario 'I cant sign in without entering an email' do
    visit '/users/new'
    click_button 'Sign up'
    expect(current_path).to eq('/users')
    expect(page).to have_content 'You must enter a valid email address'
  end


  scenario 'with a password that does not match' do
  user = User.new(email: 'alice@example.com',
          password: '12345678',
          password_confirmation: '123456789')
    expect { sign_up(user) }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content 'Password and confirmation password do not match'
  end

  # def sign_up(email: 'alice@example.com',
  #         password: '12345678',
  #         password_confirmation: '12345678')
  #   visit '/users/new'
  #   fill_in :email, with: email
  #   fill_in :password, with: password
  #   fill_in :password_confirmation, with: password_confirmation
  #   click_button 'Sign up'
  # end

  def sign_up(user)
    visit '/users/new'
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    fill_in :password_confirmation, with: user.password_confirmation
    click_button 'Sign up'
  end


  # def sign_up(email: 'alice@example.com',
  #         password: 'oranges!')
  #         visit '/users/new'
  #         expect(page.status_code).to eq(200)
  #         fill_in :email, with: email
  #         fill_in :password, with: password
  #         click_button 'Sign up'
  # end



end
