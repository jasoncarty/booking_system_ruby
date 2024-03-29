require 'spec_helper'

describe Admin::EventsController do

  let(:user) { FactoryBot.create(:user) }
  let(:admin) { FactoryBot.create(:admin) }
  let(:event) { FactoryBot.create(:event) }
  let(:calendar) { FactoryBot.create(:calendar) }

  describe "GET #index" do
    it "redirects to login if user not logged in" do
      get :index
      response.should redirect_to(login_path)
    end

    it "Does not let logged in users view the page" do
      login_user(user)
      get :index
      response.status.should be(302)
      response.should redirect_to(root_path)
    end

    it "lets logged in admins view the page" do
      login_user(admin)
      get :index
      response.status.should be(200)
    end
  end

  describe "GET #old_events" do
    it "redirects to login if user not logged in" do
      get :old_events
      response.should redirect_to(login_path)
    end

    it "Does not let logged in users view the page" do
      login_user(user)
      get :old_events
      response.status.should be(302)
      response.should redirect_to(root_path)
    end

    it "lets logged in admins view the page" do
      login_user(admin)
      get :old_events
      response.status.should be(200)
    end
  end

  describe "GET #new" do
    it "redirects to login if user not logged in" do
      get :new
      response.should redirect_to(login_path)
    end

    it "Does not let logged in users view the page" do
      login_user(user)
      get :new
      response.status.should be(302)
      response.should redirect_to(root_path)
    end

    it "lets logged in admins view the page" do
      login_user(admin)
      get :new
      response.status.should be(200)
    end
  end

  describe "POST #create" do
    it "redirects to login if user not logged in" do
      post :create, params: {
        event: {
          name: 'Test event',
          description: 'Description of test event',
          starts_at: Time.now
        }
      }
      response.should redirect_to(login_path)
    end

    it "Does not let logged in users view the page" do
      login_user(user)
      post :create, params: {
        event: {
          name: 'Test event',
          description: 'Description of test event',
          starts_at: Time.now
        }
      }
      response.status.should be(302)
      response.should redirect_to(root_path)
    end

    it "lets logged in admins create events" do
      login_user(admin)
      count = Event.all.size
      post :create, params: {
        event: {
          name: 'Test event',
          description: 'Description of test event',
          starts_at: Time.now,
          calendar_id: calendar.id
        }
      }
      response.status.should be(302)
      Event.all.size.should == count + 1
    end

    it "renders new template if event not valid" do
      login_user(admin)
      post :create, params: {
        event: {
          description: 'Description of test event',
          starts_at: Time.now
        }
      }
      response.status.should render_template(:new)
    end
  end

  describe "GET #show" do
    it "redirects to login if user not logged in" do
      get :show, params: {id: event.id}
      response.should redirect_to(login_path)
    end

    it "Does not let logged in users view the page" do
      login_user(user)
      get :show, params: {id: event.id}
      response.status.should be(302)
      response.should redirect_to(root_path)
    end

    it "lets logged in admins view the page" do
      login_user(admin)
      get :show, params: {id: event.id}
      response.status.should be(200)
    end
  end

  describe "GET #edit" do
    it "redirects to login if user not logged in" do
      get :edit, params: {id: event.id}
      response.should redirect_to(login_path)
    end

    it "Does not let logged in users view the page" do
      login_user(user)
      get :edit, params: {id: event.id}
      response.status.should be(302)
      response.should redirect_to(root_path)
    end

    it "lets logged in admins view the page" do
      login_user(admin)
      get :edit, params: {id: event.id}
      response.status.should be(200)
    end
  end

  describe "POST #update" do
    it "redirects to login if user not logged in" do
      post :update, params: {
        id: event.id,
        event: {
          name: 'Test event',
          description: 'Description of test event',
          starts_at: Time.now
        }
      }
    response.should redirect_to(login_path)
    end

    it "Does not let logged in users view the page" do
      login_user(user)
      post :update, params: {
        id: event.id,
        event: {
          name: 'Test event',
          description: 'Description of test event',
          starts_at: Time.now
        }
      }
      response.status.should be(302)
      response.should redirect_to(root_path)
    end

    it "lets logged in admins create events" do
      login_user(admin)
      count = Event.all.size
      post :update, params: {
        id: event.id,
        event: {
          name: 'Test event',
          description: 'Description of test event',
          starts_at: Time.now
        }
      }
      response.status.should be(302)
      Event.all.size.should == count + 1
    end

    it "renders edit template if event not valid" do
      login_user(admin)
      post :update, params: {
        id: event.id,
        event: {
          name: '',
          description: 'Description of test event',
          starts_at: Time.now
        }
      }
      response.status.should render_template(:edit)
    end
  end

  describe 'DELETE #destroy' do
    it "redirects to login if user not logged in" do
      delete :destroy, xhr: true,
      params: {id: event.id}
      response.should redirect_to(login_path)
    end

    it "Does not let logged in users view the page" do
      login_user(user)
      delete :destroy, xhr: true,
      params: {id: event.id}
      response.should redirect_to(root_path)
    end

    it "lets logged in admins view the page" do
      event
      count = Event.all.size
      login_user(admin)
      delete :destroy, xhr: true,
      params: {id: event.id}
      response.status.should be(200)
      Event.all.size.should == count - 1
    end
  end

end
