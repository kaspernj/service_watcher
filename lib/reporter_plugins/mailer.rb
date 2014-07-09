class ServiceWatcherReporterPlugin::Mailer
  def self.paras
    [{
      "title" => _("Email address"),
      "name" => "txtemail"
    }]
  end

  def self.report_failed(args)
    email = args[:args]["txtemail"]
    ::ReporterMailer.report_failed(email, args[:service], args[:error]).deliver!
  end

  def self.report_up_again(args)
    email = args[:args]["txtemail"]
    ::ReporterMailer.report_up_again(email, args[:service]).deliver!
  end
end
