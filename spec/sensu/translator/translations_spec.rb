require "sensu/translator/translations"

describe "Sensu::Translator::Translations" do
  include Sensu::Translator::Translations

  it "can provide a v2 spec" do
    result = v2_spec(:foo, {:bar => :baz}, "acme", "spec")
    expected = {
      :type => "Foo",
      :spec => {
        :bar => :baz,
        :organization => "acme",
        :environment => "spec"
      }
    }
    expect(result).to eq(expected)
  end
end
