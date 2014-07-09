class ReporterMailer < ActionMailer::Base
  def report_failed(email, service, error)
    raise "No error was given." unless error
    
    @service = service
    @group = @service.group
    @email = email
    @error = error
    
    subject = "[#{@group.name}] "
    subject << _("%{service_name} has failed!", service_name: service.name)
    
    mail subject: subject, to: email
  end
  
  def report_up_again(email, service)
    @service = service
    @group = @service.group
    @email = email
    
    subject = "[#{@group.name}] "
    subject << _("%{service_name} is up again", service_name: service.name)
    mail subject: subject, to: email
  end
end
