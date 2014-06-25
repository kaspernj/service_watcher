require "spec_helper"

describe Service do
  let!(:service){ create :service, :plugin => plugin, :group => group }
  let!(:plugin){ create :plugin }
  let!(:reporter){ create :reporter_mailer }
  let!(:group){ create :group }
  let!(:group_reporter){ create :group_reporter, :group => group, :reporter => reporter }
  
  it "#check" do
    option_host = service.options.destroy_all
    service.check.should eq false
    
    mail = ActionMailer::Base.deliveries.first
    mail.should_not eq nil
    
    mail.subject.should eq "#{service.name} has failed!"
    mail.body.to_s.should include "Hello sampleemail@example.com"
    mail.body.to_s.should include "The service #{service.name} has failed."
  end
end
