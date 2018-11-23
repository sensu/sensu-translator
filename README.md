[![Build Status](https://travis-ci.org/sensu/sensu-translator.svg?branch=master)](https://travis-ci.org/sensu/sensu-translator)
[![Gem Version](https://img.shields.io/gem/v/sensu-translator.svg)](https://github.com/sensu/sensu-translator/blob/master/CHANGELOG.md)
[![MIT Licensed](https://img.shields.io/github/license/sensu/sensu-translator.svg)](https://raw.githubusercontent.com/sensu/sensu-translator/master/LICENSE)
[![Join the chat at https://slack.sensu.io/](https://slack.sensu.io/badge.svg)](https://slack.sensu.io/)

# Sensu Translator

A CLI tool for translating Sensu 1.x configuration into the Sensu 2.x format.

## Installation

`gem install sensu-translator`

## Usage

```
Usage: sensu-translator [options]
    -h, --help                       Display this message
    -V, --version                    Display version
    -c, --config FILE                Sensu 1.x JSON config FILE. Default: /etc/sensu/config.json (if exists)
    -d, --config_dir DIR[,DIR]       DIR or comma-delimited DIR list for Sensu 1.x JSON config files. Default: /etc/sensu/conf.d (if exists)
    -o, --output_dir DIR             Sensu Go config output DIR. Default: /tmp/sensu_go
    -n, --namespace NAMESPACE        Sensu Go Namespace. Default: default
```

## Example

1. Translate Sensu 1.x configuration into the Sensu 2.x format

```
$ sensu-translator -c /etc/sensu/config.json -d /etc/sensu/conf.d -o /tmp/sensu_go

$ tree /tmp/sensu_go

/tmp/sensu_go
├── checks
│   ├── website-healthz.json
│   └── haproxy-backends.json
├── extensions
├── filters
├── handlers
│   ├── email.json
│   └── default.json
└── mutators
    ├── obfuscate.json
    └── tag.json
```

2. Use a configured `sensuctl` and the newly created 2.x configuration files to manage Sensu 2.x resources

```
sensuctl create -f /tmp/sensu_go/checks/website-healthz.json
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sensu/sensu-translator.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
