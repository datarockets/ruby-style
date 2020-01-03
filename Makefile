install:
	bundle install

test:
	bundle exec rspec spec

lint:
	bundle exec rubocop

.PHONY: test
