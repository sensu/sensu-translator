require "sensu/translator/translations"

describe "Sensu::Translator::Translations" do
  include Sensu::Translator::Translations

  before do
    @organization = "acme"
    @environment = "spec"
    @check = {
      :name => "spec",
      :command => "true",
      :interval => 60,
      :organization => @organization,
      :environment => @environment
    }
  end

  it "can provide a v2 spec" do
    result = v2_spec(:foo, {:bar => "baz"}, "qux", "quxx")
    expected = {
      :type => "Foo",
      :spec => {
        :bar => "baz",
        :organization => "qux",
        :environment => "quxx"
      }
    }
    expect(result).to eq(expected)
  end

  it "can translate a check with subscribers" do
    @check[:subscribers] = ["spec"]
    result = translate_check(@check, @organization, @environment)
    expected = {
      :type => "Check",
      :spec => {
        :name => "spec",
        :command => "true",
        :interval => 60,
        :subscriptions => ["spec"],
        :publish => true,
        :handlers => ["default"],
        :organization => "acme",
        :environment => "spec"
      }
    }
    expect(result).to eq(expected)
  end

  it "can translate a standalone check" do
    @check[:standalone] = true
    result = translate_check(@check, @organization, @environment)
    expect(result[:spec][:subscriptions]).to eq(["standalone"])
    expect(result[:spec][:standalone]).to be_nil
  end

  it "can translate a check with a source" do
    @check[:source] = "spec"
    result = translate_check(@check, @organization, @environment)
    expect(result[:spec][:proxy_entity_id]).to eq("spec")
    expect(result[:spec][:source]).to be_nil
  end
end
