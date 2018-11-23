require "sensu/translator/cli"

describe "Sensu::Translator::CLI" do
  it "can provide default configuration options" do
    expect(File).to receive(:exist?) { true }
    expect(Dir).to receive(:exist?) { true }
    options = Sensu::Translator::CLI.read([])
    expected = {
      :config_file => "/etc/sensu/config.json",
      :config_dirs => ["/etc/sensu/conf.d"],
      :namespace => "default",
      :output_dir => "/tmp/sensu_v2"
    }
    expect(options).to eq(expected)
  end

  it "can parse command line arguments" do
    options = Sensu::Translator::CLI.read([
      "-c", "spec/config.json",
      "-d", "spec/conf.d",
      "-o", "spec/sensu_v2",
      "-n", "spec"
    ])
    expected = {
      :config_file => "spec/config.json",
      :config_dirs => ["spec/conf.d"],
      :output_dir => "spec/sensu_v2",
      :namespace => "spec"
    }
    expect(options).to eq(expected)
  end
end
