# Change Log

All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [3.0.0] - 2022-11-08

### Added

- Added support for Ruby 3.
- Added support for Rails 5, 6, and 7.
- Added `Enumerable#as_csv` to support ActiveRecord::Relation.

### Changed

- Serialization follows modern Rails pattern.
- Simplified tests.
- CI now only checks Ruby 2.6, 2.7, and 3.0, along with Rails 5, 6 and 7.

### Removed

- Dropped explicit dependency on responders gem

## [2.0.2] - 2015-03-21

### Changed

- CSV responses will now be sent with 'Content-Disposition: attachment'

## [2.0.1] - 2015-03-21

### Added

- Allow options to be passed-through to CSV. e.g. `puts (Foo.all + Bar.all).to_csv csv_options: {col_sep:'|'}` ([#4])
- This changelog

## [2.0.0] - Sometime

- Pretty sure this is actually backwards compat. Sorry.

[3.0.0]: https://github.com/danielfone/as_csv/compare/v2.0.2...v3.0.0
[2.0.2]: https://github.com/danielfone/as_csv/compare/v2.0.1...v2.0.2
[2.0.1]: https://github.com/danielfone/as_csv/compare/v2.0.0...v2.0.1
[2.0.0]: https://github.com/danielfone/as_csv/compare/v1.0.2...v2.0.0

[#4]: https://github.com/danielfone/as_csv/pull/4
