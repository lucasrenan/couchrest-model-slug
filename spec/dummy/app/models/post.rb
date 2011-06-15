class Post < CouchRest::Model::Base
  include CouchRest::Model::Slug
  
  property :title
  property :summary
  
  slug :title, :summary
end