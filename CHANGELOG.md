# Change Log

The format is described in [Contributing notes](CONTRIBUTING.md#changelog-entry-format)

## master (unreleased)

## 0.1.0 (2019-06-27)

### Added

* Base config with community rules and some basic override rules. ([@r.dubrovsky][], [@aleks][])
* Config is based on rubocop version 0.72.0 ([@r.dubrovsky][])
* Enable `rubocop-spec` cops by default ([@r.dubrovsky][])
* Enable `Bundler/DuplicatedGem` cop by default ([@r.dubrovsky][])
* Enable `Bundler/OrderedGems` cop with allowing ordering by groups ([@r.dubrovsky][])


### Changed

* Change the limit for size of line to 120 symbols ([@r.dubrovsky][])
* Disable `Metrics/BlockLength` cop for rspec files ([@r.dubrovsky][])
* Exclude rubocop checking for some config directories ([@r.dubrovsky][])
* Enable prafering double quotes for string literals ([@r.dubrovsky][])
* Do not add spaces beetwen hash literal braces (cop `Layout/SpaceInsideHashLiteralBraces`) ([@r.dubrovsky][])
* Prefer normal style for `Layout/IndentationConsistency` cop for Rails apps too ([@r.dubrovsky][])
* Change style to `variable` for `Layout/EndAlignment` cop ([@r.dubrovsky][])
* Change style to `with_fixed_indentation` with indentation width 2 for `Layout/AlignParameter` cop ([@r.dubrovsky][])
* Always ingone hash aligning for key word arguments (cop: `Layout/AlignHash`) ([@r.dubrovsky][])
* Use prefered variable name in rescued exceptions (cop: `Naming/RescuedExceptionsVariableName`) ([@ula][])

[@r.dubrovsky]: https://github.com/roman-dubrovsky
[@aleks]: https://github.com/AleksSenkou
[@ula]: https://github.com/lazycoder9
