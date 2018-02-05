# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require File.join(File.dirname(__FILE__), 'lib', 'nypl_log_formatter', 'version')

Gem::Specification.new do |spec|
  spec.name          = "nypl_log_formatter"
  spec.version       = NyplLogFormatterVersion::VERSION
  spec.authors       = ["nodanaonlyzuul"]
  spec.email         = ["stephenschor@nypl.org"]

  spec.summary       = %q{A logger that conforms to NYPL's formatting standard}
  spec.homepage      = "https://github.com/NYPL/ruby_nypl_log_formatter"

  # To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "pry", '~> 0.11.3'
  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec', '~> 3.7'
end
