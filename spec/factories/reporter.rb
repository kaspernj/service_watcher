FactoryGirl.define do
  factory :reporter_mailer, :class => "Reporter" do
    name { Forgery(:lorem_ipsum).words(3) }
    
    association :reporter_plugin, :factory => :reporter_plugin_mailer
    
    after :create do |reporter|
      reporter.options.create!(:key => "parameter_txtemail", :value => "sampleemail@example.com")
    end
  end
end
