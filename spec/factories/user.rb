FactoryGirl.define do
  factory :user_admin, :class => "User" do
    email { Forgery(:internet).email_address }
    password "password"
    
    after :create do |user|
      user.user_roles.create!(:role => "administrator")
    end
  end
end
