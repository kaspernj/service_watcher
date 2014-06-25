module ServicesHelper
  def link_to_service service
    link_to service.name, [service.group, service]
  end
end
