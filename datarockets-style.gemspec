lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "datarockets_style/version"

Gem::Specification.new do |spec|
  spec.name          = "datarockets-style"
  spec.version       = DatarocketsStyle::VERSION
  spec.authors       = ["Roman Dubrovsky"]
  spec.email         = ["r.dubrovsky@datarockets.com"]

  spec.summary       = "Datarockets style guides and shared style configs"
  spec.homepage      = "https://github.com/datarockets/datarockets-style"
  spec.license       = "MIT"

  spec.required_ruby_version = ">= 2.6.0"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
          "public gem pushes."
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rubocop", "~> 1.39"
  spec.add_dependency "rubocop-rails", "~> 2.17.3"
  spec.add_dependency "rubocop-rspec", "~> 2.15"

  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.10"
  spec.metadata["rubygems_mfa_required"] = "true"
end
