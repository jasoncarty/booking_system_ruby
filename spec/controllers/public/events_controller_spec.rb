require 'spec_helper'

describe Public::EventsController do

  let(:user) { FactoryGirl.create(:user) }
  let(:event) { FactoryGirl.create(:event) }

  describe 'GET #index' do
    it 'redirects to login if no-one is logged in' do
      get :index
      response.should redirect_to(login_path)
    end

    it 'should let logged in users view page' do
      login_user(user)
      get :index
      response.should be_success
    end
  end

  describe 'GET #show' do
    it 'redirects to login if no-one is logged in' do
      event
      xhr :get, :show, id: event.id
      response.should redirect_to(login_path)
    end

    it 'should let logged in users view page' do
      login_user(user)
      event
      xhr :get, :show, id: event.id
      response.should be_success
    end
  end

  describe 'POST #book' do
    before :each do
      event.event_attendees.create(user_id: user.id, event_id: event.id, reserve: false)
      event.maximum_event_attendees = 1
      event.save
    end
    it 'redirects to login if no-one is logged in' do
      event
      xhr :post, :book, id: event.id
      response.should redirect_to(login_path)
    end

    it 'should let logged in users view page' do
      count = event.event_attendees.size
      login_user(user)
      xhr :post, :book, id: event.id
      response.should be_success
      event.reload.event_attendees.size.should == count + 1
    end

    it 'should make user into reserve' do
      new_user = User.create(name: 'Test Testsson', email: 'test@testsson.com', password: 'password', confirmed_at: Time.now )
      login_user(new_user)
      xhr :post, :book, id: event.id
      response.should be_success
      event.event_attendees.where(user_id: new_user.id, event_id: event.id).first.reserve.should == true
    end
  end

  describe 'POST #cancel' do
    before :each do
      event.event_attendees.create(user_id: user.id, event_id: event.id, reserve: false)
      event.save
    end
    it 'redirects to login if no-one is logged in' do
      xhr :post, :cancel, id: event.id
      response.should redirect_to(login_path)
    end

    it 'should let logged in users view page' do
      count = event.event_attendees.size
      login_user(user)
      xhr :post, :cancel, id: event.id
      response.should be_success
      event.reload.event_attendees.size.should == count - 1
    end
  end
end