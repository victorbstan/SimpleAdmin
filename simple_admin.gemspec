$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "simple_admin/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "simple_admin"
  s.version     = SimpleAdmin::VERSION
  s.authors     = ["Victor Stan"]
  s.email       = ["victor.stan@gmail.com"]
  s.homepage    = "https://github.com/victorbstan/SimpleAdmin"
  s.summary     = "No frills."
  s.description = "Provides a simple, password protected, configurable, back-end interface to your ActiveRecord models."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_runtime_dependency 'rails', '~> 4.2', '>= 4.2.0'

  s.add_dependency "simple_form", '~> 3.1'
  s.add_dependency "kaminari", '~> 0.16'
  s.add_dependency "country_select", '~> 2.1'

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "therubyracer"
end
