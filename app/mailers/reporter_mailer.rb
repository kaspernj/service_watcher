class ReporterMailer < ActionMailer::Base
  def report(email, service)
    @service = service
    @email = email
    subject = _("%{service_name} has failed!", :service_name => service.name)
    mail :subject => subject, :to => email
  end
end
