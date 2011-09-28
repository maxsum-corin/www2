require 'spec_helper'

describe Page do
  before(:each) do
    @valid_attributes = {
      :title => "Test Page",
      :url => "/pages/about/test.html",
      :content => "### Hello World",
      :content_type => "Markdown",
      :published => true,
      :tags => nil
    }
  end

  it "creates a page when passed the proper attributes" do
    lambda {
      Page.create(@valid_attributes)
    }.should change(Page,:count).by(1)
  end

  it "saves the title" do 
    p = Page.create(@valid_attributes)
    p.title.should == "Test Page"
  end
  
  it "saves the url" do 
    p = Page.create(@valid_attributes)
    p.url.should == "/pages/about/test.html"
  end

  it "creates the static page if marked as published and is valid" do
    page = Page.create(@valid_attributes)
    File.file?(page.file_name).should be_true
  end
end
