require "spec_helper"

describe Service do
  context "#check" do
    let!(:service){ create :service, :plugin => plugin, :group => group }
    let!(:plugin){ create :plugin }
    let!(:reporter){ create :reporter_mailer }
    let!(:group){ create :group }
    let!(:group_reporter){ create :group_reporter, :group => group, :reporter => reporter }
    
    before do
      ActionMailer::Base.deliveries.clear
    end
    
    it "sends the right email" do
      option_host = service.options.destroy_all
      service.check.should eq false
      
      mail = ActionMailer::Base.deliveries.first
      mail.should_not eq nil
      
      mail.subject.should eq "#{service.name} has failed!"
      mail.body.to_s.should include "Hello sampleemail@example.com"
      mail.body.to_s.should include "The service #{service.name} has failed."
    end
    
    it "should not send double mails" do
      option_host = service.options.destroy_all
      service.check.should eq false
      ActionMailer::Base.deliveries.length.should eq 1
      service.failed?.should eq true
      service.check.should eq false
      service.failed?.should eq true
      ActionMailer::Base.deliveries.length.should eq 1
    end
    
    it "sends 'up again' emails" do
      service.update_column(:failed, true)
      service.check.should eq true
      ActionMailer::Base.deliveries.length.should eq 1
      service.failed?.should eq false
      
      mail = ActionMailer::Base.deliveries.first
      mail.should_not eq nil
      
      mail.subject.should eq "#{service.name} is up again"
      mail.body.to_s.should include "Hello sampleemail@example.com"
      mail.body.to_s.should include "The service #{service.name} is up again."
      
      # Dont send a mail for every check.
      service.check.should eq true
      ActionMailer::Base.deliveries.length.should eq 1
    end
  end
end
