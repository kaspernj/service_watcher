class DesignBox
  def self.boxt(title, width = "100%")
    if width.is_a?(Fixnum) or width.is_a?(Integer)
      width = "#{width}px"
    end
    
    html = "<div style=\"width: #{width};\">"
    html << "<div class=\"box\">"
    
    if title
      html << "<div class=\"box_title\">#{title}</div>"
    end
    
    return html.html_safe
  end
  
  def self.boxb
    return "</div></div>".html_safe
  end
end
