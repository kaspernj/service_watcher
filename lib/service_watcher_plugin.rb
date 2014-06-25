class ServiceWatcherPlugin
  def self.const_missing(name)
    file_path = "#{Rails.root}/lib/plugins/#{StringCases.camel_to_snake(name)}.rb"
    raise "File didn't exist: #{file_path}" unless File.exists? file_path
    load file_path
    raise LoadError, "Could not load: #{name}" unless ServiceWatcherPlugin.const_defined?(name)
    return ServiceWatcherPlugin.const_get(name)
  end
end
