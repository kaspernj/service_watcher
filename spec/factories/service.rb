FactoryGirl.define do
  factory :service do
    name { Forgery(:lorem_ipsum).words(3) }
    association :group, :factory => :group
    association :plugin, :factory => :plugin
    
    after :create do |plugin|
      plugin.options.create!(:key => "parameter_txtport", :value => 443)
      plugin.options.create!(:key => "parameter_txthost", :value => "www.google.com")
      plugin.options.create!(:key => "parameter_txtaddr", :value => "search?q=google")
      plugin.options.create!(:key => "parameter_txthtmlregexmatch", :value => "/<title>google - Google Search<\/title>/")
      plugin.options.create!(:key => "parameter_chessl", :value => "on")
    end
  end
end
