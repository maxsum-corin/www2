require 'spec_helper'

describe "test_models/index.html.haml" do
  before(:each) do
    assign(:test_models, [
      stub_model(TestModel,
        :name => "Name"
      ),
      stub_model(TestModel,
        :name => "Name"
      )
    ])
  end

  it "renders a list of test_models" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
