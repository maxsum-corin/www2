require 'spec_helper'

describe "test_models/new.html.haml" do
  before(:each) do
    assign(:test_model, stub_model(TestModel,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new test_model form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => test_models_path, :method => "post" do
      assert_select "input#test_model_name", :name => "test_model[name]"
    end
  end
end
