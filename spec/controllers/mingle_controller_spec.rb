require 'spec_helper'

describe MingleController do

  before(:each) do
    controller.stub!(:require_user).and_return(true)
  end

  # GET /new
  describe "mingle/new" do

    it "should list the mingle cards" do
      mock_mingle = mock(Mingle)
      Mingle.should_receive(:new).and_return(mock_mingle)
      get :new, :format => :js
      assigns[:mingle].should == mock_mingle
      assigns[:error].should be_false
      response.should render_template('mingle/new')
      response.should be_ok
    end

  end

  # POST /
  describe "mingle/create" do

    it "should create a new mingle ticket" do
      user = mock(User, :username => "bob")
      controller.instance_variable_set(:@current_user, user)
      mock_mingle = mock(Mingle, :number => 1)
      Mingle.should_receive(:create).and_return(mock_mingle)
      post :create, :format => :js
      assigns[:mingle].should == mock_mingle
      response.should render_template('mingle/create')
      response.should be_ok
    end

  end

  describe "handle_active_resource_errors" do

    it "should return an error in page if cannot connect to Mingle server" do
      Mingle.should_receive(:new).and_return(SocketError)
      get :new, :format => :js
      response.should render_template('mingle/new')
      response.should be_ok
    end

    it "should return an error in page if cannot authenticate to Mingle server" do
      Mingle.should_receive(:new).and_return(ActiveResource::UnauthorizedAccess)
      get :new, :format => :js
      response.should render_template('mingle/new')
      response.should be_ok
    end

  end

end
