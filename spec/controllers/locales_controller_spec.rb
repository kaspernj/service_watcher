require "spec_helper"

describe LocalesController do
  let(:user_admin){ create :user_admin, :locale => "en" }
  
  it "#create" do
    sign_in user_admin
    request.env["HTTP_REFERER"] = dashboard_index_url
    post :create, :locale => "da"
    response.should be_redirect
    response.location.should eq dashboard_index_url
    user_admin.reload.locale.should eq "da"
    I18n.locale.should eq :da
  end
end
