module MenusHelper
  def menus
    if signed_in?
      menus = [
        link_to(_("Dashboard"), dashboard_index_path),
        link_to(_("Log out"), destroy_user_session_path, :method => :delete)
      ]
    else
      menus = [
        (link_to _("Log in"), new_user_session_path)
      ]
    end
    
    return menus
  end
end
