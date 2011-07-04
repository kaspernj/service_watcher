class Service_watcher_interface_web
  def initialize(args = {})
    require "rubygems"
    require "knjappserver"
    
    @args = args
    
    raise "No ':db_args' given for creating a database-connection." if !@args[:db_args]
    if @args[:db_args].is_a?(Knj::Db)
      @db = args[:db_args]
    else
      @db = Knj::Db.new(@args[:db_args])
    end
    
    @erbhandler = Knjappserver::ERBHandler.new
    @appserver = Knjappserver.new(
      :debug => false,
      :autorestart => false,
      :verbose => false,
      :title => "Service_watcher",
      :port => @args[:port],
      :host => @args[:host],
      :default_page => "index.rhtml",
      :doc_root => "#{File.dirname(__FILE__)}/../pages",
      :hostname => false,
      :default_filetype => "text/html",
      :engine_webrick => true,
      :error_report_emails => [@args[:admin_email]],
      :error_report_from => @args[:admin_email],
      :locales_root => "#{File.dirname(__FILE__)}/../locales",
      :max_requests_working => 5,
      :filetypes => {
        :jpg => "image/jpeg",
        :gif => "image/gif",
        :png => "image/png",
        :html => "text/html",
        :htm => "text/html",
        :rhtml => "text/html",
        :css => "text/css",
        :xml => "text/xml",
        :js => "text/javascript"
      },
      :handlers => [
        :file_ext => "rhtml",
        :callback => @erbhandler.method(:erb_handler)
      ],
      :db => @db,
      :smtp_args => @args[:smtp]
    )
    @appserver.update_db
    @appserver.start
  end
end