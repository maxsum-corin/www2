require 'spec_helper'

describe "test_models/edit.html.haml" do
  before(:each) do
    @test_model = assign(:test_model, stub_model(TestModel,
      :name => "MyString"
    ))
  end

  it "renders the edit test_model form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => test_models_path(@test_model), :method => "post" do
      assert_select "input#test_model_name", :name => "test_model[name]"
    end
  end
end
