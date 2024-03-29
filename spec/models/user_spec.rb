require 'spec_helper'

describe User do

  before do
    @user = User.new(name: "Example User", email: "user@example.com", 
                     password: "foobar", password_confirmation: "foobar")
  end

  subject { @user }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:admin) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:microposts) }
  it { should respond_to(:microposts) }
  it { should respond_to(:feed) }

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

  describe "micropost associations" do

    before { @user.save }
    let!(:older_micropost) do 
      FactoryGirl.create(:micropost, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_micropost) do
      FactoryGirl.create(:micropost, user: @user, created_at: 1.hour.ago)
    end

    it "should destroy associated microposts" do
      microposts = @user.microposts.dup
      @user.destroy
      microposts.should_not be_empty
      microposts.each do |micropost|
        Micropost.find_by_id(micropost.id).should be_nil
      end
    end
    describe "status" do
      let(:unfollowed_post) do
        FactoryGirl.create(:micropost, user: FactoryGirl.create(:user))
      end

      its(:feed) { should include(newer_micropost) }
      its(:feed) { should include(older_micropost) }
      its(:feed) { should_not include(unfollowed_post) }
    end
  end
end