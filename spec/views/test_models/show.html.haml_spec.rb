require 'spec_helper'

describe "test_models/show.html.haml" do
  before(:each) do
    @test_model = assign(:test_model, stub_model(TestModel,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
