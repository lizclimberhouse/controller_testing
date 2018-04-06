require 'rails_helper'

RSpec.describe BankAccountsController, type: :controller do
  login_user

  let (:valid_attributes) {
    { institution: 'Chase', amount: 10000, active: true, }
  }

  let (:invalid_attributes) {
    { institution: '', amount: 200, active: true }
  }

  describe "GET #index" do
    it "returns a success response" do
      # can overwrite any params you want like user: @user (make sure to uncomment out the login_user up aboce) or amount.
      bank_account = FactoryBot.create(:bank_account, user: @user, amount: 10000 ) #@user.bank_accounts.create! valid_attributes
      # binding.pry
      get :index
      expect(response).to be_success
    end
  end
   
  describe "GET #show" do
    it "returns a success response" do
      bank_account = @user.bank_accounts.create! valid_attributes
      get :show, params: {id: bank_account.id}
      expect(response).to be_success
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_success
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      bank_account = @user.bank_accounts.create! valid_attributes
      get :edit, params: {id: bank_account.id}
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      # creates new account
      it "creates a new account" do
        expect {
          post :create, params: { bank_account: valid_attributes }
        }.to change(BankAccount, :count).by(1)
      end
      #redirects to path
      it "redirects to created account" do 
        post :create, params: { bank_account: valid_attributes }
        expect(response).to redirect_to(BankAccount.last)
      end
    end
    context "with invalid params" do
      it "does not create an accout" do
        expect {
          post :create, params: { bank_account: invalid_attributes }
        }.to change(BankAccount, :count).by(0)
      end
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { bank_account: invalid_attributes }
        expect(response).to be_success
      end
    end
  end

  describe "PUT #update" do
    let(:new_attribute) {
      { amount: 220 }
    }
    before(:each) do 
      @bank_account = FactoryBot.create(:bank_account, user: @user)
    end
    context "with valid params" do
      # let(:new_attribute) {
      #   { amount: 220 }
      # }

      it "updates the requested account" do
        # bank_account = @user.bank_accounts.create! valid_attributes
        put :update, params: { id: @bank_account.id, bank_account: new_attribute }
        @bank_account.reload
        expect(@bank_account.amount).to eq(new_attribute[:amount])
      end
      it "redirects to an account" do
        # bank_account = @user.bank_accounts.create! valid_attributes
        put :update, params: { id: @bank_account.id, bank_account: new_attribute }
        expect(response).to redirect_to(@bank_account)
      end
    end
    context "with invalid params" do
      it "does not update the requested account" do
        # bank_account = @user.bank_accounts.create! valid_attributes
        put :update, params: { id: @bank_account.id, bank_account: invalid_attributes }
        @bank_account.reload
        expect(@bank_account.institution).to_not eq("") # can also write it this way -> eq(invalid_attributes[:institution])
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested account" do
      bank_account = @user.bank_accounts.create! valid_attributes
      expect {
        delete :destroy, params: { id: bank_account.id }
      }.to change(BankAccount, :count).by(-1)
    end
    it "redirects to the account index" do
      bank_account = @user.bank_accounts.create! valid_attributes
      delete :destroy, params: { id: bank_account.id }
      expect(response).to redirect_to(bank_accounts_url)
    end
  end

end
