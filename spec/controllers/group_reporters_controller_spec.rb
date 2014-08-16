require "spec_helper"

describe GroupReportersController do
  let(:user_admin){ create :user_admin }
  let(:reporter){ create :reporter_mailer }
  let!(:group){ create :group }
  let(:group_reporter){ create :group_reporter }
  let(:valid_attributes){ {reporter_id: reporter.id} }

  render_views

  context "when logged in" do
    before do
      sign_in user_admin
    end

    it "#new" do
      get :new, group_id: group.id
      response.should be_success
    end

    it "#create" do
      post :create, group_id: group.id, group_reporter: valid_attributes
      response.should redirect_to(group)
    end

    it "#destroy" do
      delete :destroy, group_id: group.id, id: group_reporter.id

      expect {
        group_reporter.reload
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
