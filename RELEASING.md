# Releasing

* Update `version.rb` file accordingly.
* Update `CHANGELOG.md` file.
* Update `Gemfile.lock` file via running `bundle install`.
* Build and publish (and verify that everything ok):

```bash
bundle exec rake build
gem push *built_file*
```
* Tag the release: `git tag vVERSION`.
* Push changes: `git push --tags`.
* Update the release notes on GitHub.com.
* Announce the new release,
   making sure to say "thank you" to the contributors
   who helped shape this version!

## Versioning stragety

As versioning stragety, we're using SemVer: `MAJOR.MINOR.PATCH`

A `MAJOR` version must be incremented if there are any backward-incompatible breaking changes included in a release. This has the benefit of making it easy for anyone to quickly identify if a new version will work differently than a previous one.

Usually, we'll incremented it on updating major versions of rubocop dependecies. Ideally, it should be synchronize with major verion of `rubocop`.

The `MINOR` version must be incremented if there are backward-compatible functionality is introduced. In the strictest sense, this means you should be able to upgrade to a new minor version without experiencing any breaking changes.

Usually, we'll incremented it on changing list of cops, updating minor versions of dependencie.

The `PATCH` version is meant for backward-compatible bug fixes. You should expect no new functionality with a new patch version, only improvements.

Usually, we'll use it for updating pathc version of depencies or fixing bugs of the last version. Change rules of cops in most cases should be added to minor version.
