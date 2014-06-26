class ReporterMailer < ActionMailer::Base
  def report_failed(email, service)
    @service = service
    @email = email
    subject = _("%{service_name} has failed!", :service_name => service.name)
    mail :subject => subject, :to => email
  end
  
  def report_up_again(email, service)
    @service = service
    @email = email
    subject = _("%{service_name} is up again", :service_name => service.name)
    mail :subject => subject, :to => email
  end
end
