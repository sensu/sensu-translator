require "spec_helper"

RSpec.describe Sensu::Translator do
  it "has a version number" do
    expect(Sensu::Translator::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
