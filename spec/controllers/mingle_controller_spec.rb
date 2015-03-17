require 'spec_helper'

describe MingleController, type: 'controller' do

  before(:each) do
    allow(controller).to receive(:require_user).and_return(true)
  end

  # GET /new
  describe "mingle/new" do
    it "should list the mingle cards" do
      mock_mingle = double(Mingle)
      expect(Mingle).to receive(:new).and_return(mock_mingle)
      xhr :get, :new
      expect(assigns[:mingle]).to eql(mock_mingle)
      expect(assigns[:error]).to eql(false)
      expect(response).to render_template('mingle/new')
      expect(response.status).to eql(200)
    end
  end

  # POST /
  describe "mingle/create" do
    it "should create a new mingle ticket" do
      user = double(User, username: "bob")
      controller.instance_variable_set(:@current_user, user)
      mock_mingle = double(Mingle, number: 1)
      expect(Mingle).to receive(:create).and_return(mock_mingle)
      xhr :post, :create
      expect(assigns[:mingle]).to eql(mock_mingle)
      expect(response).to render_template('mingle/create')
      expect(response.status).to eql(200)
    end
  end

  describe "handle_active_resource_errors" do
    it "should return an error in page if cannot connect to Mingle server" do
      expect(Mingle).to receive(:new).and_return(SocketError)
      xhr :get, :new
      expect(response).to render_template('mingle/new')
      expect(response.status).to eql(200)
    end
    
    it "should return an error in page if cannot authenticate to Mingle server" do
      expect(Mingle).to receive(:new).and_return(ActiveResource::UnauthorizedAccess)
      xhr :get, :new
      expect(response).to render_template('mingle/new')
      expect(response.status).to eql(200)
    end
  end

end
