# Releasing

* Update `version.rb` file accordingly.
* Update `CHANGELOG.md` file
* Tag the release: `git tag vVERSION`
* Push changes: `git push --tags`
* Update the release notes on GitHub.com
* Build and publish:

```bash
bundle exec rake build
gem push *todo*
```

* Announce the new release,
   making sure to say "thank you" to the contributors
   who helped shape this version!
