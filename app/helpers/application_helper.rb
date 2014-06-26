module ApplicationHelper
  def header_title
    @header_title ||= content_for(:header_title)
    return @header_title
  end
  
  def locales_collection
    {
      _("Danish") => :da,
      _("English") => :en
    }
  end
end
