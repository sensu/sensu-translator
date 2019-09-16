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
      :api_version => "core/v2",
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
      :api_version => "core/v2",
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
    expect(result[:metadata][:annotations]["sensu.io.json_attributes".to_sym]).to eq('{"foo":"bar"}')
  end

  it "can add fatigue_check/occurrance annotation when occurrences is present" do
    @check[:occurrences] = 10
    result = translate_check(@check, @namespace, "spec")
    expect(result[:metadata][:annotations]["fatigue_check/occurrences"]).to eq("10")
  end

  it "can add fatigue_check/interval annotation when refresh is present" do
    @check[:refresh] = 3600
    result = translate_check(@check, @namespace, "spec")
    expect(result[:metadata][:annotations]["fatigue_check/interval"]).to eq("3600")
  end
end
