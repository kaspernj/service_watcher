class ServiceWatcherPlugin::SshSwapping
  def self.paras
    return [{
      "title" => _("Hostname"),
      "name" => "txthost"
    },{
      "title" => _("Port"),
      "name" => "txtport",
      "default" => "22"
    },{
      "title" => _("Username"),
      "name" => "txtuser"
    },{
      "type" => "password",
      "title" => _("Password"),
      "name" => "txtpasswd"
    }]
  end
end