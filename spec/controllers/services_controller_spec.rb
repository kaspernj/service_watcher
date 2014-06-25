require "spec_helper"

describe ServicesController do
  let(:service){ create :service, :group => group, :plugin => plugin }
  let(:group){ create :group }
  let(:plugin){ create :plugin }
  let(:user_admin){ create :user_admin }
  
  render_views
  
  context "when signed in" do
    before do
      sign_in user_admin
    end
    
    it "#new" do
      get :new, :group_id => group.id
      response.should be_success
    end
    
    it "#create" do
      post :create, :group_id => group.id, :service => {:name => "Test create", :plugin_id => plugin.id}
      assigns(:service).errors.to_a.should eq []
      latest_service = Service.last
      response.location.should eq edit_group_service_url(group, latest_service)
    end
    
    it "#edit" do
      get :edit, :group_id => group.id, :id => service.id
      response.should be_success
    end
    
    it "#update" do
      patch :update, :group_id => group.id, :id => service.id, :service => {:name => "New name"}
      service.reload.name.should eq "New name"
      response.location.should eq group_service_url(group, service)
    end
    
    it "#destroy" do
      delete :destroy, :group_id => group.id, :id => service
      response.location.should eq dashboard_index_url
    end
    
    it "#check" do
      result = service.check
      service.activities.where(:key => "service.check.unsuccessful").first.should eq nil
      result.should eq true
      service.activities.where(:key => "service.check.successful").first.should_not eq nil
    end
  end
end
