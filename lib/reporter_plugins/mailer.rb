class ServiceWatcherReporterPlugin::Mailer
  def self.paras
    [{
      "title" => _("Email address"),
      "name" => "txtemail"
    }]
  end
  
  def self.report_failed(args)
    service = args[:service]
    email = args[:args]["txtemail"]
    error = args[:error]
    ::ReporterMailer.report_failed(email, service, error).deliver!
  end
  
  def self.report_up_again(args)
    service = args[:service]
    email = args[:args]["txtemail"]
    ::ReporterMailer.report_up_again(email, service).deliver!
  end
end
