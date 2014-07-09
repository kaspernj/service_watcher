task "update_reporter_plugins" => :environment do
  reporters_path = "#{Rails.root}/lib/reporter_plugins"

  found = []
  Dir.foreach(reporters_path) do |file|
    next unless File.extname(file) == ".rb"

    snake_name = file.slice(0, file.length - 3)
    class_name = StringCases.snake_to_camel(snake_name)

    reporter_plugin = ReporterPlugin.find_or_initialize_by(:name => class_name)
    reporter_plugin.save!

    found << class_name
  end

  ReporterPlugin.where("name NOT IN (?)", found).destroy_all
end
