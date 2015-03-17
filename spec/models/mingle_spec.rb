require 'spec_helper'

describe Mingle do

  let(:client) { Mingle4r::MingleClient.new('', '', '') }

  before do
    Mingle.reset
    allow(Mingle).to receive(:client).and_return(client)
  end

  describe "projects" do

    it "should get a list of projects" do
      expect(Mingle.projects.sort).to eql(MingleSettings['projects'].split(/\s*,\s*/).sort)
    end

    it "should return empty list when Mingle is not setup" do
      expect(Setting).to receive(:[]).and_return(nil)
      expect(Mingle.projects).to eql([])
    end

  end

  describe "fields" do

    it "should get a list of fields" do
      expect(Mingle.fields.sort).to eql(MingleSettings['fields'].split(/\s*,\s*/).sort)
    end

    it "should return empty list when Mingle is not setup" do
      expect(Setting).to receive(:[]).and_return(nil)
      expect(Mingle.fields).to eql([])
    end

  end

  it "should return the default attributes" do
    expect(Mingle.default_attributes.keys).to include('card_type_name')
    expect(Mingle.default_attributes['card_type_name']).to eql(MingleSettings['card_type'])
    expect(Mingle.default_attributes.keys).to include('name')
    expect(Mingle.default_attributes.keys).to include('properties')
  end

  describe "all" do
    it "with conditions for each project" do
      expect(client).to receive(:execute_mql).exactly(Mingle.projects.size).times.with("SELECT 'number', 'name', 'status', 'owner' WHERE Type = 'Story' AND 'CRM Account' = 2").and_return([])
      Mingle.all(:conditions => ["'CRM Account' = 2"])
    end
  end

  describe "reset should clear the" do

    it "client" do
      Mingle.send(:class_variable_set, :@@client, "TestClient")
      expect(Mingle.send(:class_variable_get, :@@client)).to eql("TestClient")
      Mingle.reset
      expect(Mingle.send(:class_variable_get, :@@client)). to eql(nil)
    end

    it "projects" do
      Mingle.send(:class_variable_set, :@@projects, "Project1")
      expect(Mingle.send(:class_variable_get, :@@projects)).to eql("Project1")
      Mingle.reset
      expect(Mingle.send(:class_variable_get, :@@projects)).to eql(nil)
    end

    it "project options" do
      Mingle.send(:class_variable_set, :@@project_options, "Project options")
      expect(Mingle.send(:class_variable_get, :@@project_options)).to eql("Project options")
      Mingle.reset
      expect(Mingle.send(:class_variable_get, :@@project_options)).to eql(nil)
    end

  end

end

describe "Mingle client" do

  it "should setup a new client if not already initialized" do
    project = MingleSettings[:projects].split(/\s*,\s*/).first
    expect(MingleClient).to receive(:new).with(MingleSettings['url'], MingleSettings['username'], MingleSettings['password'], project)
    Mingle.client
  end

end
