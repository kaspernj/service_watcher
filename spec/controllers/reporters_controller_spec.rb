require "spec_helper"

describe ReportersController do
  let(:user_admin){ create :user_admin }
  let(:reporter){ create :reporter_mailer }
  let(:reporter_plugin){ create :reporter_plugin_mailer }
  let(:valid_attributes){ {name: "TestMailer", reporter_plugin_id: reporter_plugin.id} }

  render_views

  context "when logged in as admin" do
    before do
      sign_in user_admin
    end

    it "#index" do
      get :index
      response.should be_success
    end

    it "#new" do
      get :new
      response.should be_success
    end

    it "#create" do
      post :create, reporter: valid_attributes
      assigns(:reporter).errors.to_a.should eq []
      reporter = Reporter.last
      response.should redirect_to(edit_reporter_path(reporter))
    end

    it "#show" do
      get :show, id: reporter.id
      response.should be_success
    end

    it "#edit" do
      get :edit, id: reporter.id
      response.should be_success
    end

    it "#update" do
      patch :update, id: reporter.id, reporter: valid_attributes
      response.should redirect_to(reporter)
    end

    it "#destroy" do
      delete :destroy, id: reporter.id

      expect {
        reporter.reload
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
