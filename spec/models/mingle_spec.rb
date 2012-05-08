require 'spec_helper'

describe Mingle do

  use_vcr_cassette 'mingle', :record => :new_episodes

  before(:each) do
    Mingle.reset
  end

  describe "client" do
    
    it "should setup a new client if not already initialized" do
      project = @@mingle_settings[:projects].split(/\s*,\s*/).first
      MingleClient.should_receive(:new).with(@@mingle_settings[:url], @@mingle_settings[:username], @@mingle_settings[:password], project)
      Mingle.client
    end

  end
  
  describe "projects" do
  
    it "should get a list of projects" do
      Mingle.projects.sort.should == @@mingle_settings[:projects].split(/\s*,\s*/).sort
    end
    
    it "should return empty list when Mingle is not setup" do
      Setting.stub!(:[]).and_return(nil)
      Mingle.projects.should == []
    end
    
  end
  
  describe "project options" do
  
    it "should return project options" # do
      # Mingle.project_options.should == []
    # end
  
  end
  
  it "should return the default attributes" do
    Mingle.default_attributes.keys.should include('card_type_name')
    Mingle.default_attributes['card_type_name'].should == @@mingle_settings[:card_type]
    Mingle.default_attributes.keys.should include('name')
    Mingle.default_attributes.keys.should include('properties')
  end

end
