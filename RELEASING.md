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
