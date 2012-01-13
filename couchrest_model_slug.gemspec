$:.push File.expand_path("../lib", __FILE__)
require "couchrest/model/slug/version"

Gem::Specification.new do |s|
  s.name        = "couchrest_model_slug"
  s.summary     = "A simple gem to generate slugs using couchrest model, based on mongoid_slug."
  s.files       = Dir["{app,lib,config}/**/*"] + ["MIT-LICENSE", "Rakefile", "Gemfile", "README.rdoc"]
  s.version     = CouchRest::Model::Slug::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Lucas Renan"]
  s.email       = "contato@lucasrenan.com"
  s.homepage    = "https://github.com/lucasrenan/couchrest-model-slug"
  
  s.require_paths = ["lib"]

  s.add_dependency "couchrest_model", "~> 1.1.2"
  s.add_dependency "stringex", "~> 1.3"
end