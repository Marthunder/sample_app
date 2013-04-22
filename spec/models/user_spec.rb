require 'spec_helper'

describe User do

  before do
    @user = User.new(name: "Example User", email: "user@example.com")
  end

  subject { @user }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:admin) }
  it { should respond_to(:authenticate) }

  it { should be_valid }
  it { should_not be_admin }

  describe "with admin attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it { should be_admin }
  end

  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end
  #describe "when email format is invalid" do
  #  it "should be invalid" do
  #    addresses = %w[user@foo,com user_at_foo.org example.user@foo.
  #                   foo@bar_baz.com foo@bar+baz.com]
  #    addresses.each do |invalid_address|
  #      @user.email = invalid_address
  #      @user.should_not be_valid
  #    end      
  #  end
  #end

  #describe "when email format is valid" do
  #  it "should be valid" do
  #    addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
  #    addresses.each do |valid_address|
  #      @user.email = valid_address
  #      @user.should be_valid
  #    end      
  #  end
  #end
end