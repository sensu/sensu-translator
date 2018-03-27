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
    -o, --output_dir DIR             Sensu 2.0 config output DIR. Default: /tmp/sensu_v2
    -O, --organization ORG           Sensu 2.0 RBAC Organization. Default: default
    -E, --environment ENV            Sensu 2.0 RBAC Environment. Default: default
```

## Example

```
$ sensu-translator -c /etc/sensu/config.json -d /etc/sensu/conf.d -o /tmp/sensu_v2

$ tree /tmp/sensu_v2

/tmp/sensu_v2
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

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sensu/sensu-translator.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
