# Provide a simple gemspec so you can easily use your enginex
# project in your rails apps through git.
Gem::Specification.new do |s|
  s.name = "couchrest_model_slug"
  s.summary = "Insert CouchrestModelSlug summary."
  s.description = "Insert CouchrestModelSlug description."
  s.files = Dir["{app,lib,config}/**/*"] + ["MIT-LICENSE", "Rakefile", "Gemfile", "README.rdoc"]
  s.version = "0.0.1"
  
  s.add_dependency "couchrest_model", "1.1.0.rc1"
  s.add_dependency "stringex", "1.2.1"
end