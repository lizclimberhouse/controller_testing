module ControllerMacros
  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = User.create(
        email: 'test@test.com', 
        password: 'password', 
        first_name: 'Testuser', 
        last_name: 'TestLast', 
        age: 30, 
        gender: 'Female' 
      )
      sign_in @user
    end
  end
end