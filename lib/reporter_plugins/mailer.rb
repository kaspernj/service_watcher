class ServiceWatcherReporterPlugin::Mailer
  def self.paras
    [{
      "title" => _("Email address"),
      "name" => "txtemail"
    }]
  end
  
  def execute
  end
end
