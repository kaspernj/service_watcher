task "update_plugins" => :environment do
  plugins_path = "#{Rails.root}/lib/plugins"
  
  found = []
  Dir.foreach(plugins_path) do |file|
    next unless File.extname(file) == ".rb"
    
    snake_name = file.slice(0, file.length - 3)
    class_name = StringCases.snake_to_camel(snake_name)
    
    plugin = Plugin.find_or_initialize_by(:name => class_name)
    plugin.save!
    
    found << class_name
  end
  
  Plugin.where("name NOT IN (?)", found).destroy_all
end
