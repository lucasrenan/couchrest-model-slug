class Post < CouchRest::Model::Base
  include CouchRest::Model::Slug
  
  property :title
  
  slug :title
end