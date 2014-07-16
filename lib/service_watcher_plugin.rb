class ServiceWatcherPlugin
  def self.const_missing(name)
    ServiceWatcherPlugin.load_sub_constant(name)
    raise LoadError, "Could not load: #{name}" unless ServiceWatcherPlugin.const_defined?(name)
    return ServiceWatcherPlugin.const_get(name)
  end

  def self.load_sub_constant(name)
    file_path = "#{Rails.root}/lib/plugins/#{StringCases.camel_to_snake(name)}.rb"
    raise "File didn't exist: #{file_path}" unless File.exists? file_path
    load file_path
  end
end
