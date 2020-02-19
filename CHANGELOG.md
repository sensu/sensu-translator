# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

This CHANGELOG follows the format listed [here](https://github.com/sensu-plugins/community/blob/master/HOW_WE_CHANGELOG.md)

## [Unreleased]

## [1.1.0] - 2020-02-19
### Added
- Translate check occurrences and refresh to fatigue_check annotations

## [1.0.1] - 2018-12-18

### Fixed
- Now getting Sensu Go config file name from object metadata
- Check timeout no longer treated as custom
- Unable to translate log lines now include object inspection

## [1.0.0] - 2018-12-04

### Changed
- Now using an annotation for json_attributes instead of a label
- Namespaced the json_attributes annotation, sensu.io.*

### Added
- Custom attributes added to Go label "json_attributes"

## [0.4.0] - 2018-11-29

### Changed
- Renamed Sensu 2.x -> Sensu Go
- Replaced Organization/Environment with Namespace
- Sensu Go configuration object files now include mandatory metadata

### Added
- Custom attributes added to Go label "json_attributes"

## [0.3.0] - 2018-05-04

### Fixed
- Removed Sensu Core lib gem loading version pins

## [0.2.0] - 2018-05-01

### Added
- CHANGELOG guidelines location (@majormoses)
- Updated gemspec to support later sensu-json and sensu-settings releases

## [0.1.0] - 2018-03-26
### Added
- Inital release (still experimental)

### Changed

### Fixed

### Breaking Change
