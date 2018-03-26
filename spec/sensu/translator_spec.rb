require "spec_helper"

RSpec.describe Sensu::Translator do
  it "has a version number" do
    expect(Sensu::Translator::VERSION).not_to be nil
  end
end
