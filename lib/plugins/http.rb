class ServiceWatcherPlugin::Http
  def self.paras
    return [{
      "title" => _("Port"),
      "name" => "txtport",
      "default" => "80"
    },{
      "title" => _("Hostname"),
      "name" => "txthost"
    },{
      "title" => _("Get address"),
      "name" => "txtaddr"
    },{
      "title" => _("SSL"),
      "name" => "chessl"
    },{
      "title" => _("HTML regex match"),
      "name" => "txthtmlregexmatch"
    }]
  end

  def self.check(paras)
    raise "No arguments given." if paras.empty?

    if paras["chessl"] == "1" || paras["chessl"] == "on"
      ssl = true
    else
      ssl = false
    end

    Http2.new(host: paras["txthost"], port: paras["txtport"], ssl: ssl) do |http|
      response = http.get(paras["txtaddr"])

      if paras["txthtmlregexmatch"].present?
        regex = Knj::Strings.regex(paras["txthtmlregexmatch"])

        unless regex.match(response.body)
          $stderr.puts "HTML was: #{response.body}"
          raise _("Could not match the following regex: '%{regex}'.", regex: paras["txthtmlregexmatch"])
        end
      end
    end
  end
end
