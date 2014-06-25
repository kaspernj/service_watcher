require "spec_helper"

describe GroupsController do
  let(:user_admin){ create :user_admin }
  let(:group){ create :group }
  
  render_views
  
  context "when signed in" do
    before do
      sign_in user_admin
    end
    
    it "#new" do
      get :new
      response.should be_success
    end
    
    it "#create" do
      post :create, :group => {:name => "Test"}
      group = Group.last
      response.location.should eq group_url(group)
    end
    
    it "#edit" do
      get :edit, :id => group.id
      response.should be_success
    end
    
    it "#update" do
      patch :update, :id => group.id, :group => {:name => "new_name"}
      response.location.should eq group_url(group)
      group.reload.name.should eq "new_name"
    end
    
    it "#destroy" do
      delete :destroy, :id => group.id
      response.location.should eq dashboard_index_url
    end
  end
end
