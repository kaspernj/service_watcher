require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "ServiceWatcherInterfaceWeb" do
  it "should initialize and start on port 1516" do
    require "rubygems"
    require "knjrbfw"
    require "knj/autoload"
    require "service_watcher_interface_web"
    
    db_schema_path = "#{File.dirname(__FILE__)}/../files/database_schema.rb"
    
    db_path = "#{File.dirname(__FILE__)}/../files/database_sample.sqlite3"
    
    db = Knj::Db.new(
      :type => "sqlite3",
      :path => db_path,
      :return_keys => "symbols"
    )
    
    swi = Service_watcher_interface_web.new(
      :host => "0.0.0.0",
      :port => 1516,
      :db_args => db
    )
  end
end
