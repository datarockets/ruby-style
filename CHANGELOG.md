# Change Log

The format is described in [Contributing notes](CONTRIBUTING.md#changelog-entry-format).

## master (unreleased)

### Changed

* Added `RSpec/ExampleLength` cop to style guide. ([@a.branzeanu][])

## 0.5.0 (2019-10-26)

### Changed

* Split single rubocop config to smaller (for ruby, rails and rspec). ([@r.dubrovsky][])
* Update rubocop to `0.75.1`.
* Update rubocop-rspec to `1.36.0`.
* Use block style for `RSpec/ExpectChange` cop. ([@r.dubrovsky][])
* Add `RSpec/MessageSpies` cop to style guide. ([@r.dubrovsky][])

### Fixed

* Fix `RSpec/DescribedClass`'s error when `described_class` is used as part of a constant. This is part of rubocop-rspec changes.

## 0.4.0 (2019-08-13)

### Changed

* Update rubocop-rspec to `1.35.0`. ([@r.dubrovsky][])
* Use contenxt-dependent style for curly braces around hash params. ([@v.kuzmik][])
* Use leading underscores in cached instance variable name (cop: `Naming/MemoizedInstanceVariableName`). ([@ula][])
* Allow use `for` wiht `RSpec/ContextWording` cop. ([@r.dubrovsky][])
* Change `Layout/AlignArguments` and `Layout/IndentFirstHashElement` cops for aliging arguments with fixed indentation. ([@r.dubrovsky][])
* Enable `Layout/MultilineMethodCallIndentation` cop for aliging arguments with fixed indentation. ([@r.dubrovsky][], [@ula][])

## 0.3.0 (2019-08-02)

### Changed

* Update rubocop to `0.74.0`. ([@r.dubrovsky][])
* Update rubocop-rspec to `1.34.1`. ([@r.dubrovsky][])
* Move shared rubocop config into `config` directory. ([@r.dubrovsky][])
* Allow writing empty methods in two lines. ([@v.kuzmik][])
* Disable `Style/FrozenStringLiteralComment` cop by default. ([@r.dubrovsky][])

### Fixed

* [#4222](https://github.com/rubocop-hq/rubocop/issues/4222): Disable `Lint/AmbiguousBlockAssociation` for Rspec directory. ([@r.dubrovsky][])
* [#65](https://github.com/datarockets/datarockets-style/issues/65): Exclude `node_modules` from rubocop scope. ([@r.dubrovsky][])

## 0.2.0 (2019-07-17)

### Changed

* Update rubocop to `0.73.0`. ([@r.dubrovsky][])
* Use prefered variable name in rescued exceptions (cop: `Naming/RescuedExceptionsVariableName`). ([@ula][])
* Disable `RSpec/ImplicitSubject` cop for rspec files. ([@r.dubrovsky][])

## 0.1.0 (2019-06-27)

### Added

* Base config with community rules and some basic override rules. ([@r.dubrovsky][], [@aleks][])
* Config is based on rubocop version 0.72.0. ([@r.dubrovsky][])
* Enable `rubocop-spec` cops by default. ([@r.dubrovsky][])
* Enable `Bundler/DuplicatedGem` cop by default. ([@r.dubrovsky][])
* Enable `Bundler/OrderedGems` cop with allowing ordering by groups. ([@r.dubrovsky][])


### Changed

* Change the limit for size of line to 120 symbols. ([@r.dubrovsky][])
* Disable `Metrics/BlockLength` cop for rspec files. ([@r.dubrovsky][])
* Exclude rubocop checking for some config directories. ([@r.dubrovsky][])
* Enable prafering double quotes for string literals. ([@r.dubrovsky][])
* Do not add spaces beetwen hash literal braces (cop `Layout/SpaceInsideHashLiteralBraces`). ([@r.dubrovsky][])
* Prefer normal style for `Layout/IndentationConsistency` cop for Rails apps too. ([@r.dubrovsky][])
* Change style to `variable` for `Layout/EndAlignment` cop. ([@r.dubrovsky][])
* Change style to `with_fixed_indentation` with indentation width 2 for `Layout/AlignParameter` cop. ([@r.dubrovsky][])
* Always ingone hash aligning for key word arguments. (cop: `Layout/AlignHash`) ([@r.dubrovsky][])

[@r.dubrovsky]: https://github.com/roman-dubrovsky
[@aleks]: https://github.com/AleksSenkou
[@ula]: https://github.com/lazycoder9
[@v.kuzmik]: https://github.com/TheBlackArroVV/
[@a.branzeanu]: https://github.com/texpert

