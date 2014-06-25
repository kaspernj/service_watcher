class ServiceWatcherReporterPlugin::Mailer
  def self.paras
    [{
      "title" => _("Email address"),
      "name" => "txtemail"
    }]
  end
  
  def self.report(args)
    service = args[:service]
    email = args[:args]["txtemail"]
    ::ReporterMailer.report(email, service).deliver!
  end
end
