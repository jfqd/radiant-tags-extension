# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'radiant-tags-extension'

Gem::Specification.new do |s|
  s.name        = 'radiant-tags-extension'
  s.version     = RadiantTagsExtension::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = RadiantTagsExtension::AUTHORS
  s.email       = RadiantTagsExtension::EMAIL
  s.homepage    = RadiantTagsExtension::HOMEPAGE
  s.summary     = RadiantTagsExtension::SUMMARY
  s.description = RadiantTagsExtension::DESCRIPTION
  
  s.add_dependency 'has_many_polymorphs'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features,vendor/plugins/*/test,vendor/plugins/*/spec,vendor/plugins/*/features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  # TODO: update for usage with Bundler/Gemfile once Radiant gets that capability
  s.post_install_message = %{
  Add this to your radiant project by adding the following line to your environment.rb:
    config.gem 'radiant-tags-extension', :version => '#{RadiantTagsExtension::VERSION}'
  }
end
