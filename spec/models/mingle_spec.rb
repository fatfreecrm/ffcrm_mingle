require 'spec_helper'

describe Mingle do

  let(:client) { Mingle4r::MingleClient.new('', '', '') }

  before do
    Mingle.reset
    Mingle.stub!(:client).and_return(client)
  end

  describe "projects" do

    it "should get a list of projects" do
      Mingle.projects.sort.should == MingleSettings['projects'].split(/\s*,\s*/).sort
    end

    it "should return empty list when Mingle is not setup" do
      Setting.stub!(:[]).and_return(nil)
      Mingle.projects.should == []
    end

  end

  describe "fields" do

    it "should get a list of fields" do
      Mingle.fields.sort.should == MingleSettings['fields'].split(/\s*,\s*/).sort
    end

    it "should return empty list when Mingle is not setup" do
      Setting.stub!(:[]).and_return(nil)
      Mingle.fields.should == []
    end

  end

  it "should return the default attributes" do
    Mingle.default_attributes.keys.should include('card_type_name')
    Mingle.default_attributes['card_type_name'].should == MingleSettings['card_type']
    Mingle.default_attributes.keys.should include('name')
    Mingle.default_attributes.keys.should include('properties')
  end

  describe "all" do

    it "with conditions for each project" do
      client.should_receive(:execute_mql).exactly(Mingle.projects.size).times.with("SELECT 'number', 'name', 'status', 'owner' WHERE Type = 'Story' AND 'CRM Account' = 2").and_return([])
      cards = Mingle.all(:conditions => ["'CRM Account' = 2"])
    end

  end

  describe "reset should clear the" do

    it "client" do
      Mingle.send(:class_variable_set, :@@client, "TestClient")
      Mingle.send(:class_variable_get, :@@client).should == "TestClient"
      Mingle.reset
      Mingle.send(:class_variable_get, :@@client).should be_nil
    end

    it "projects" do
      Mingle.send(:class_variable_set, :@@projects, "Project1")
      Mingle.send(:class_variable_get, :@@projects).should == "Project1"
      Mingle.reset
      Mingle.send(:class_variable_get, :@@projects).should be_nil
    end

    it "project options" do
      Mingle.send(:class_variable_set, :@@project_options, "Project options")
      Mingle.send(:class_variable_get, :@@project_options).should == "Project options"
      Mingle.reset
      Mingle.send(:class_variable_get, :@@project_options).should be_nil
    end

  end

  it "should return the project options"

end

describe "Mingle client" do

  it "should setup a new client if not already initialized" do
    project = MingleSettings[:projects].split(/\s*,\s*/).first
    MingleClient.should_receive(:new).with(MingleSettings['url'], MingleSettings['username'], MingleSettings['password'], project)
    Mingle.client
  end

end
