$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "inherited/attributes/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "inherited-attributes"
  s.version     = Inherited::Attributes::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["John Naegle", "Rob Mathews"]
  s.email       = ["john.naegle@goodmeasures.com"]
  s.homepage    = "https://github.com/GoodMeasuresLLC/inherited-attributes"
  s.summary     = "Extends ancestry to allow attributes to be inherited from ancestors."
  s.description = s.summary
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "ancestry"
  s.add_dependency "activerecord", [">= 4.2"]

  s.add_development_dependency "sqlite3"
  s.add_development_dependency('appraisal')
  s.add_development_dependency('shoulda')
  s.add_development_dependency('rspec', '~> 3.0')

  s.add_development_dependency('byebug')
  s.add_development_dependency('pry')


  s.required_ruby_version = ">= 2.2.0"
end
