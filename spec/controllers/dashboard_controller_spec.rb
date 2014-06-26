require "spec_helper"

describe DashboardController do
  it "should redirect to sign in page when not signed in" do
    get :index
    response.should be_redirect
    response.location.should eq new_user_session_url
  end
end
