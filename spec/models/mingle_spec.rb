require 'spec_helper'

describe Mingle do

  use_vcr_cassette 'mingle', :record => :new_episodes

  before(:each) do
    Mingle.reset
  end

  describe "client" do
    
    it "should setup a new client if not already initialized" do
      project = MingleSettings[:projects].split(/\s*,\s*/).first
      MingleClient.should_receive(:new).with(MingleSettings[:url], MingleSettings[:username], MingleSettings[:password], project)
      Mingle.client
    end

  end
  
  describe "projects" do
  
    it "should get a list of projects" do
      Mingle.projects.sort.should == MingleSettings[:projects].split(/\s*,\s*/).sort
    end
    
    it "should return empty list when Mingle is not setup" do
      Setting.stub!(:[]).and_return(nil)
      Mingle.projects.should == []
    end
    
  end
  
  describe "fields" do
  
    it "should get a list of fields" do
      Mingle.fields.sort.should == MingleSettings[:fields].split(/\s*,\s*/).sort
    end
    
    it "should return empty list when Mingle is not setup" do
      Setting.stub!(:[]).and_return(nil)
      Mingle.fields.should == []
    end
    
  end
    
  it "should return the default attributes" do
    Mingle.default_attributes.keys.should include('card_type_name')
    Mingle.default_attributes['card_type_name'].should == MingleSettings[:card_type]
    Mingle.default_attributes.keys.should include('name')
    Mingle.default_attributes.keys.should include('properties')
  end
  
  describe "all" do
  
    it "should return no cards if no id matches" do
      cards = Mingle.all(:conditions => ["'CRM Account' = 2"])
      cards.size.should == 1
      cards.first.name.should == "Test Story"
      cards.first.status.should == "Open"
    end
  
    it "should return no cards if no id matches" do
      Mingle.all(:conditions => ["'CRM Account' = 1"]).should == []
    end
    
    it "should catch authentication errors" do
      original_mingle_settings = Setting[:mingle]
      Setting[:mingle] = Setting[:mingle].merge( {:username => "", :password => ""} )
      lambda{ Mingle.all }.should_not raise_error(ActiveResource::UnauthorizedAccess)
      Mingle.all.should == []
      Setting[:mingle] = original_mingle_settings
    end
    
  end
  
  describe "reset should clear the" do
  
    it "client" do
      Mingle.class_variable_set(:@@client, "TestClient")
      Mingle.class_variable_get(:@@client).should == "TestClient"
      Mingle.reset
      Mingle.class_variable_get(:@@client).should be_nil
    end
    
    it "projects" do
      Mingle.class_variable_set(:@@projects, "Project1")
      Mingle.class_variable_get(:@@projects).should == "Project1"
      Mingle.reset
      Mingle.class_variable_get(:@@projects).should be_nil
    end
    
    it "project options" do
      Mingle.class_variable_set(:@@project_options, "Project options")
      Mingle.class_variable_get(:@@project_options).should == "Project options"
      Mingle.reset
      Mingle.class_variable_get(:@@project_options).should be_nil
    end
  
  end

  it "should return the project options"

end
