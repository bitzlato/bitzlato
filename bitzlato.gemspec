require_relative 'lib/bitzlato/version'

Gem::Specification.new do |spec|
  spec.name          = "bitzlato"
  spec.version       = Bitzlato::VERSION
  spec.authors       = ["Danil Pismenny"]
  spec.email         = ["danil@brandymint.ru"]

  spec.summary       = %q{Ruby HTTP API client library and cli for bitzlato.bz}
  spec.description   = %q{Ruby HTTP API client library and cli to bitzlato.bz for wallets, trades and money}
  spec.homepage      = "https://github.com/finfex/bitzlato"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/finfex/bitzlato"
  spec.metadata["changelog_uri"] = "https://github.com/finfex/bitzlato/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'faraday', '>= 0.17'
  spec.add_dependency 'jwt', '~> 2.3.0.dev'
  spec.add_dependency 'json', '~> 2.0'
  spec.add_development_dependency 'pry-nav'
end
