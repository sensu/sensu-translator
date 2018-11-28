require "sensu/translator/translations"

describe "Sensu::Translator::Translations" do
  include Sensu::Translator::Translations

  before do
    @namespace = "spec"
    @check = {
      :command => "true",
      :interval => 60
    }
  end

  it "can provide a go spec" do
    result = go_spec(:foo, {:bar => "baz"}, "qux", "quux")
    expected = {
      :type => "Foo",
      :metadata => {
        :namespace => "qux",
        :name => "quux",
        :labels => {},
        :annotations => {}
      },
      :spec => {
        :bar => "baz"
      }
    }
    expect(result).to eq(expected)
  end

  it "can translate a check with subscribers" do
    @check[:subscribers] = ["spec"]
    result = translate_check(@check, @namespace, "spec")
    expected = {
      :type => "Check",
      :metadata => {
        :namespace => "spec",
        :name => "spec",
        :labels => {},
        :annotations => {}
      },
      :spec => {
        :command => "true",
        :subscriptions => ["spec"],
        :publish => true,
        :interval => 60,
        :handlers => ["default"]
      }
    }
    expect(result).to eq(expected)
  end

  it "can translate a standalone check" do
    @check[:standalone] = true
    result = translate_check(@check, @namespace, "spec")
    expect(result[:spec][:subscriptions]).to eq(["standalone"])
    expect(result[:spec][:standalone]).to be_nil
  end

  it "can translate a check with a source" do
    @check[:source] = "spec"
    result = translate_check(@check, @namespace, "spec")
    expect(result[:spec][:proxy_entity_name]).to eq("spec")
    expect(result[:spec][:source]).to be_nil
  end

  it "can translate a check with custom attributes" do
    @check[:subscribers] = ["spec"]
    @check[:foo] = "bar"
    result = translate_check(@check, @namespace, "spec")
    expect(result[:metadata][:labels][:json_attributes]).to eq('{"foo":"bar"}')
  end
end
